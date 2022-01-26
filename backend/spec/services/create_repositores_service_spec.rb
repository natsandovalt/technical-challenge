# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreateRepositoriesService, type: :model do
  before(:all) do
    @user = create(:user)
  end

  describe '#call' do
    it 'creates the repositories on the database' do
      expect { CreateRepositoriesService.new(username: 'natsandovalt').call }.to change(Repository, :count)
    end

    it 'does not creates repositories when they have been added' do
      CreateRepositoriesService.new(username: 'natsandovalt').call
      expect { CreateRepositoriesService.new(username: 'natsandovalt').call }.to_not change(Repository, :count)
    end

    it 'raise GithubUserNotFound when user does not exists on github' do
      @user.username = 'nonexistentuser'
      expect { CreateRepositoriesService.new(username: 'nonexistentuser').call }.to raise_error(GithubUserNotFoundError)
    end
  end
end
