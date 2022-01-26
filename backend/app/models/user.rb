# frozen_string_literal: true

class User < ApplicationRecord
  has_many :repositories

  validates :username, presence: true
  validates :github_id, presence: true
end
