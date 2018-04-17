# frozen_string_literal: true

module Flickr
  module SearchService
    def self.call(query, preload = 3)
      raise ArgumentError, 'Search query can`t be empty' if query.empty?
      Flickr.photos.search(text: query, sort: :relevance, per_page: 50)
    end
  end
end
