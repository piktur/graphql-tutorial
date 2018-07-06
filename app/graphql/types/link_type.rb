# frozen_string_literal: true

Types::LinkType = GraphQL::ObjectType.define do
  name 'Link'

  field :id, !types.ID
  field :url, !types.String
  field :descritpion, !types.String
end
