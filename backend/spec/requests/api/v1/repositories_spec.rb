# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Repositories', type: :request do
  describe 'GET /index' do
    it 'gets repositories for natsandovalt' do
      get api_v1_user_repositories_path(user_id: 'natsandovalt')
      body = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(body.size).to eq(10)
    end

    it 'get bad request status when user does not exist in github' do
      get api_v1_user_repositories_path(user_id: 'nonexistentuser')
      expect(response).to have_http_status(400)
    end

    it 'get repositories of natsandovalt that matches with technical-challenge' do
      get api_v1_user_repositories_path(user_id: 'natsandovalt', query: 'technical-challenge')
      body = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(body.size).to eq(1)
    end

    it 'get repositories of natsandovalt that matches with ejercicio' do
      get api_v1_user_repositories_path(user_id: 'natsandovalt', query: 'ejercicio')
      body = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(body.size).to eq(2)
    end
  end
end
