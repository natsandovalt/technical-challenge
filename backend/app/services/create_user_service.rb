# frozen_string_literal: true

class CreateUserService
  include FaradayHelper

  def initialize(username:)
    @username = username
  end

  def call
    user = connection.get("#{ENV['GITHUB_URL']}/users/#{@username}").body

    raise(GithubUserNotFoundError, "Could't find github user: #{@username}!") if user['message'] == 'Not Found'

    User.create_with(username: user['login'], avatar_url: user['avatar_url'],
                     url: user['url'], name: user['name']).find_or_create_by(github_id: user['id'])
  end
end
