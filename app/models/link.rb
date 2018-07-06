# frozen_string_literal: true

class Link < ApplicationRecord

  belongs_to :user, optional: true

end
