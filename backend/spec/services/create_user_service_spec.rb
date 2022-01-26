# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreateUserService, type: :model do
  describe '#call' do
    it 'creates a user on the database' do
      expect { CreateUserService.new(username: 'natsandovalt').call }.to change(User, :count)
    end

    it 'does not create a user when is already on the database' do
      CreateUserService.new(username: 'natsandovalt').call

      expect { CreateUserService.new(username: 'natsandovalt').call }.to_not change(User, :count)
    end

    it 'raise Exceptions::GithubUserNotFound when user does not exists on github' do
      expect { CreateUserService.new(username: 'nonexistentuser').call }.to raise_error(GithubUserNotFoundError)
    end
  end
end
