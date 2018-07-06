# frozen_string_literal: true

Types::MutationType = GraphQL::ObjectType.define do
  name 'Mutation'

  field :createLink, function: Resolvers::CreateLink.new
  field :createUser, function: Resolvers::CreateUser.new
  field :createVote, function: Resolvers::CreateVote.new
  field :authenticate, function: Resolvers::Authenticate.new
end
