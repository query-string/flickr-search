# frozen_string_literal: true

Flickr.configure do |config|
  config.api_key       = Rails.application.credentials.flickr.fetch(:key)
  config.shared_secret = Rails.application.credentials.flickr.fetch(:secret)
  config.pagination    = :will_paginate
end
