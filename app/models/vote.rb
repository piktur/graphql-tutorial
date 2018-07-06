# frozen_string_literal: true

class Vote < ApplicationRecord # rubocop:disable Documentation

  belongs_to :user, validate: true
  belongs_to :link, validate: true

end
