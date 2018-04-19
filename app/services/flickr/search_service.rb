# frozen_string_literal: true

module Flickr
  module SearchService
    def self.call(attrs)
      query = attrs[:query]
      page  = attrs[:page]

      raise ArgumentError, 'Search query can`t be empty' if query.empty?
      Flickr.photos.search(text: query, sort: :relevance, per_page: 50, page: page)
    end
  end
end
