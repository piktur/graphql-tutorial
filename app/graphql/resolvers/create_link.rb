# frozen_string_literal: true

module Resolvers

  class CreateLink < GraphQL::Function # rubocop:disable Documentation

    argument :description, !types.String
    argument :url, !types.String

    type Types::LinkType

    def call(_obj, args, ctx)
      Link.create!(
        description: args[:description],
        url:         args[:url],
        user:        ctx[:current_user]
      )
    rescue ActiveRecord::RecordInvalid => e
      GraphQL::ExecutionError.new("Invalid input: #{e.record.errors.full_messages.join(', ')}")
    end

  end

end
