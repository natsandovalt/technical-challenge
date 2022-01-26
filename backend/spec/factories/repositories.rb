# frozen_string_literal: true

FactoryBot.define do
  factory :repository do
    github_id { 1 }
    user { User.new }
    name { 'name' }
    full_name { 'full_name' }
    private { false }
    html_url { 'html_url' }
    description { 'description' }
    fork { false }
    url { 'url' }
  end
end
