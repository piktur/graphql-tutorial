# frozen_string_literal: true

Types::QueryType = GraphQL::ObjectType.define do
  name 'Query'

  field :allLinks, !types[Types::LinkType] do
    description 'A list of Links'
    resolve ->(_obj, _args, _ctx) { Link.all }
  end
end
