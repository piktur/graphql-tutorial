# frozen_string_literal: true

module Resolvers

  class CreateUser < GraphQL::Function # rubocop:disable Documentation

    AuthProviderInput = GraphQL::InputObjectType.define do
      name 'AuthProviderSignUpData'

      argument :email, Types::AuthProviderEmailInput
    end

    argument :name, !types.String
    argument :authProvider, !AuthProviderInput

    type Types::UserType

    def call(_opts, args, _ctx)
      User.create!(
        name:     args[:name],
        email:    args.dig(:authProvider, :email, :email),
        password: args.dig(:authProvider, :email, :password)
      )
    end

  end

end
