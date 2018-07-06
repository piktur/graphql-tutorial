# frozen_string_literal: true

module Resolvers

  class CreateVote < GraphQL::Function

    argument :linkId, types.ID

    type Types::VoteType

    def call(_obj, args, ctx)
      Vote.create!(
        link: Link.find_by(id: args[:linkId]),
        user: ctx[:current_user]
      )
    end

  end

end
