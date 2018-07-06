# frozen_string_literal: true

require 'test_helper'

module Resolvers

  class AuthenticateTest < ActiveSupport::TestCase

    setup do
      # @user = users(:one)
      @user = User.create! name: 'Pleb', email: 'neo@lith.com', password: 'password'
      @email = @user.email
      @password = @user.password
    end

    def perform(args = {}) # rubocop:disable OptionHash
      fn = Resolvers::Authenticate.new
      fn.call(nil, args, {})
    end

    test 'issues token' do
      result = perform(
        email: {
          email:    @email,
          password: @password
        }
      )

      assert result.present?
      assert result.token.is_a?(String)
      assert result.user.present?
      assert_equal result.user, @user
    end

    test 'does not issue token if credentials nil' do
      assert_nil perform
    end

    test 'does not issue token if user not found' do
      assert_nil perform(email: { email: '', password: @password })
    end

    test 'does not issue token if password invalid' do
      assert_nil perform(email: { email: @email, password: '' })
    end

  end

end
