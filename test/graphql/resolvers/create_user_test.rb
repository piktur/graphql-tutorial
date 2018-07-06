# frozen_string_literal: true

require 'test_helper'

module Resolvers

  class CreateUserTest < ActiveSupport::TestCase

    def perform(args = {}) # rubocop:disable OptionHash
      fn = Resolvers::CreateUser.new
      fn.call(nil, args, {})
    end

    test 'creating new user' do
      user = perform(
        name:         'John Smith',
        authProvider: {
          email: {
            email:    'user@example.com',
            password: 'password'
          }
        }
      )

      assert user.persisted?
      assert_equal user.name, 'John Smith'
      assert_equal user.email, 'user@example.com'
    end

  end

end
