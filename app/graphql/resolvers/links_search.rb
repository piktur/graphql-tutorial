# frozen_string_literal: true

require 'search_object/plugin/graphql'

module Resolvers

  class LinksSearch < GraphQL::Function

    LinkFilter = GraphQL::InputObjectType.define do
      name 'LinkFilter'

      argument :OR, -> { types[LinkFilter] }
      argument :description_contains, types.String
      argument :url_contains, types.String
    end

    include SearchObject.module(:graphql)

    scope { Link.all }

    type !types[Types::LinkType]

    option :filter, type: LinkFilter, with: :apply_filter
    option :first, type: types.Int, with: :apply_first
    option :skip, type: types.Int, with: :apply_skip

    def apply_filter(scope, input)
      branches = normalize_filters(input).reduce { |a, e| a.or(e) }
      scope.merge(branches)
    end

    def apply_first(scope, value)
      scope.limit(value)
    end

    def apply_skip(scope, value)
      scope.offset(value)
    end

    def normalize_filters(input, branches = [])
      scope = Link.all
      scope = scope.where('description LIKE ?', "%#{input['description_contains']}%") if input['description_contains']
      scope = scope.where('url LIKE ?', "%#{input['url_contains']}%") if input['url_contains']

      branches << scope

      input['OR'].reduce(branches) { |a, e| normalize_filters(e, a) } if input['OR'].present?

      branches
    end

  end

end
