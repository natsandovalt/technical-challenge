# frozen_string_literal: true

GithubUserNotFoundError = Class.new(StandardError) # move to other file

class CreateUserService
  include FaradayHelper

  def initialize(username:)
    @username = username
  end

  def call
    user = connection.get("https://api.github.com/users/#{@username}").body
    # repos = conn.get("https://api.github.com/users/#{user_params}/repos", { per_page: 100 }).body

    raise(GithubUserNotFoundError, "Could't find github user: #{@username}!") if user['message'] == 'Not Found'

    User.transaction do
      User.create_with(username: user['login'], avatar_url: user['avatar_url'],
                       url: user['url'], name: user['name']).find_or_create_by(github_id: user['id'])
    end
  end
end
