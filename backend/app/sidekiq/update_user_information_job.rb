# frozen_string_literal: true

class UpdateUserInformationJob
  include Sidekiq::Job
  include FaradayHelper
  include LoggerHelper

  def perform
    log_info('UpdateUserInformationService')
    User.all.each do |user|
      github_user = connection.get("#{ENV['GITHUB_URL']}/users/#{user.username}").body
      user.update(
        avatar_url: github_user['avatar_url'],
        url: github_user['url'],
        name: github_user['name']
      )
    end
  end
end
