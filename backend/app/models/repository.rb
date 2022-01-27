# frozen_string_literal: true

class Repository < ApplicationRecord
  searchkick word_middle: %i[name full_name description]

  belongs_to :user

  validates :github_id, presence: true
  validates :name, presence: true
  validates :html_url, presence: true
end
