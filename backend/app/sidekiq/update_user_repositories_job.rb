# frozen_string_literal: true

class UpdateUserRepositoriesJob
  include Sidekiq::Job
  include FaradayHelper
  include LoggerHelper

  def perform
    log_info('UpdateUserRepositoriesService')
    User.all.each do |user|
      repos = connection.get("#{ENV['GITHUB_URL']}/users/#{user.username}/repos", { per_page: 100 }).body
      update_repositories(repos)
    end
  end

  private

  def update_repositories(repos)
    repos.each do |repo|
      repository = Repository.find_or_create_by(github_id: repo['id'])
      repository.update(
        name: repo['name'],
        full_name: repo['full_name'],
        private: repo['private'],
        html_url: repo['html_url'],
        description: repo['description'],
        fork: repo['fork'],
        url: repo['url']
      )
    end
  end
end
