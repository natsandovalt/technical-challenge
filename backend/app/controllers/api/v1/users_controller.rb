# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      include LoggerHelper

      def index
        log_info('Creating user')
        user = CreateUserService.new(username: user_params).call
        log_info('Creating repositories')
        CreateRepositoriesService.new(username: user_params).call
        render json: user.as_json.except('repositories')
      rescue GithubUserNotFoundError => e
        log_error(e.message)
        render json: payload(e.message, 400), status: :bad_request
      end

      private

      def user_params
        params.require(:username)
      end

      def payload(message, status)
        { message: message, status: status }
      end
    end
  end
end
