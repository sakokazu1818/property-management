# frozen_string_literal: true

class Administrator < ApplicationRecord
  has_secure_password

  validates :name, :password_digest, presence: true
  validates :name, uniqueness: true
end
