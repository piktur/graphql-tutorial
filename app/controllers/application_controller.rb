# frozen_string_literal: true

class ApplicationController < ActionController::Base # rubocop:disable Documentation

  protect_from_forgery with: :exception

end
