# frozen_string_literal: true

class User < ApplicationRecord # rubocop:disable Documentation

  has_secure_password

  validate :name, presence: true
  validate :email, presence: true, uniqueness: true

end
