# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    username { 'natsandovalt' }
    github_id { 1 }
    avatar_url { 'avatar_url' }
    name { 'Natalia Sandoval' }
    url { 'url' }
  end
end
