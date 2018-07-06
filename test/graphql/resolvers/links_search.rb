# frozen_string_literal: true

require 'test_helper'

module Resolvers

  class LinksSearchTest < ActiveSupport::TestCase

    setup do
      @user = users(:one)
      @links = Array.new(3) do |e|
        Link.create!(description: "Link #{e}", url: "http://link.#{e}.com", user: @user)
      end
    end

    def find(input = {})
      LinksSearch.call(nil, input, nil)
    end

    test 'it filters links by description or url' do
      result = find(
        filter: {
          'description_contains' => '0',
          'OR' => [
            {
              'url_contains' => '1',
              'OR' => [
                { 'url_contains' => '2' }
              ]
            },
            { 'description_contains' => '1' }
          ]
        }
      )

      assert_equal(result.sort, @links.sort)
    end

    test 'it returns all Links if no filter' do
      result = find.map(&:id)
      @links.map { |e| assert_includes(result, e.id) }
    end

  end

end
