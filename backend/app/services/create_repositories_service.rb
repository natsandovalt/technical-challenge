# frozen_string_literal: true

class CreateRepositoriesService
  include FaradayHelper
  include LoggerHelper

  def initialize(username:)
    @username = username
  end

  def call
    log_info("CreateRepositoriesService with username: #{@username}")
    user = User.find_by(username: @username)
    repos = connection.get("#{ENV['GITHUB_URL']}/users/#{@username}/repos", { per_page: 100 }).body

    raise(GithubUserNotFoundError, "Could't find github user: #{@username}!") if user_not_found(repos)

    create_repositories(repos, user) if user.repositories.empty?

    user.repositories
  end

  private

  def create_repositories(repos, user)
    Repository.transaction do
      repos.each do |repo|
        Repository.create(
          github_id: repo['id'],
          name: repo['name'],
          full_name: repo['full_name'],
          private: repo['private'],
          html_url: repo['html_url'],
          description: repo['description'],
          fork: repo['fork'],
          url: repo['url'],
          user: user
        )
      end
    end
  end

  def user_not_found(repos)
    !repos.is_a?(Array) && repos['message'] == 'Not Found'
  end
end
