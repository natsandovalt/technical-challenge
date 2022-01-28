# frozen_string_literal: true

module Api
  module V1
    class RepositoriesController < ApplicationController
      def index
        user = CreateUserService.new(username: user_params).call
        CreateRepositoriesService.new(username: user_params).call
        render json: repositories(user)
      rescue GithubUserNotFoundError => e
        render json: payload(e.message, 400), status: :bad_request
      end

      private

      def user_params
        params.require(:user_id)
      end

      def query_params
        params.permit(:query)
      end

      def repositories(user)
        query_params['query'].present? ? user.repositories.search(query_params['query']) : user.repositories
      end
    end
  end
end
