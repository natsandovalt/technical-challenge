# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with valid attributes' do
    user = build_user

    expect(user).to be_valid
  end

  it 'is not valid without username' do
    user = build_user
    user.username = nil

    expect(user).to_not be_valid
  end

  it 'is not valid without github_id' do
    user = build_user
    user.github_id = nil

    expect(user).to_not be_valid
  end

  def build_user
    build(:user)
  end
end
