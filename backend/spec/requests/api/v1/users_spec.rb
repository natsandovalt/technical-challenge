# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Users', type: :request do
  describe 'GET /index' do
    it 'gets profile for natsandovalt' do
      get api_v1_users_path, params: { username: 'natsandovalt' }
      body = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(body).to have_key('username')
      expect(body['username']).to eq('natsandovalt')
    end

    it 'gets profile for HeyHomie' do
      get api_v1_users_path, params: { username: 'HeyHomie' }
      body = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(body).to have_key('username')
      expect(body['username']).to eq('HeyHomie')
    end

    it 'get bad request status when user does not exist in github' do
      get api_v1_users_path, params: { username: 'nonexistentuser' }
      expect(response).to have_http_status(400)
    end

    it 'get internal server error status when no param is given' do
      get api_v1_users_path
      expect(response).to have_http_status(500)
    end
  end
end
