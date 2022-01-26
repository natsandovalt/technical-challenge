# frozen_string_literal: true

require 'faraday_middleware'

GithubUserNotFoundError = Class.new(StandardError)

class CreateUserService
  def initialize(username:)
    @username = username
  end

  def call
    user = conn.get("https://api.github.com/users/#{@username}").body
    # repos = conn.get("https://api.github.com/users/#{user_params}/repos", { per_page: 100 }).body

    raise(GithubUserNotFoundError, "Could't find github user: #{@username}!") if user['message'] == 'Not Found'

    User.transaction do
      User.create_with(username: user['login'], avatar_url: user['avatar_url'],
                       url: user['url'], name: user['name']).find_or_create_by(github_id: user['id'])
      # CreateRepositoriesService
    end
  end

  private

  def conn
    Faraday.new do |f|
      f.request :authorization, 'Bearer', ENV['GITHUB_TOKEN']
      f.request :json
      f.request :retry
      f.response :follow_redirects
      f.response :json
    end
  end
end
