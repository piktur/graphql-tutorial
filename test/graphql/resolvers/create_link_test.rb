# frozen_string_literal: true

require 'test_helper'

module Resolvers

  class CreateLinkTest < ActiveSupport::TestCase

    def perform(args = {}) # rubocop:disable OptionHash
      fn = Resolvers::CreateLink.new
      fn.call(nil, args, {})
    end

    test 'creating new link' do
      link = perform(
        url:         'http://example.com',
        description: 'description'
      )

      assert link.persisted?
      assert_equal link.description, 'description'
      assert_equal link.url, 'http://example.com'
    end

  end

end
