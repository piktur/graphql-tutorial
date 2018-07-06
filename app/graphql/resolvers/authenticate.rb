# frozen_string_literal: true

module Resolvers

  class Authenticate < GraphQL::Function # rubocop:disable Documentation

    argument :email, !Types::AuthProviderEmailInput

    type do
      name 'AuthToken'

      field :token, types.String
      field :user, Types::UserType
    end

    def call(_opts, args, ctx)
      input = args[:email]

      return if input.nil?

      return unless (user = User.find_by(email: input[:email]))

      ctx[:session][:token] = generate_token(user)

      AuthToken.new(ctx[:session][:token], user) if user.authenticate(input[:password])
    end

    private

      # @todo Implement JWT issuer
      def generate_token(user)
        encryptor = ActiveSupport::MessageEncryptor.new(
          Rails.application.secrets.secret_key_base.byteslice(0..31)
        )
        encryptor.encrypt_and_sign("user-id:#{user.id}")
      end

  end

end
