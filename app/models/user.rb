# frozen_string_literal: true

class User < ApplicationRecord # rubocop:disable Documentation

  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  has_many :votes
  has_many :links

end
