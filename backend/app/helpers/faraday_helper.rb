# frozen_string_literal: true

require 'faraday_middleware'

module FaradayHelper
  def connection
    Faraday.new do |f|
      f.request :authorization, 'Bearer', ENV['GITHUB_TOKEN']
      f.request :json
      f.request :retry
      f.response :follow_redirects
      f.response :json
    end
  end
end
