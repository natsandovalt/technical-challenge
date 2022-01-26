# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Repository, type: :model do
  describe 'Validations' do
    it 'is valid with valid attributes' do
      repository = build_repository

      expect(repository).to be_valid
    end

    it 'is not valid without github_id' do
      repository = build_repository
      repository.github_id = nil

      expect(repository).to_not be_valid
    end

    it 'is not valid without name' do
      repository = build_repository
      repository.name = nil

      expect(repository).to_not be_valid
    end

    it 'is not valid without html_url' do
      repository = build_repository
      repository.html_url = nil

      expect(repository).to_not be_valid
    end
  end

  describe 'Associations' do
    it { should belong_to(:user) }
  end

  def build_repository
    build(:repository)
  end
end
