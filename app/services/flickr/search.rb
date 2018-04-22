# frozen_string_literal: true

module Flickr
  class Search
    PER_PAGE = 50

    extend Comandor
    attr_reader :query, :page, :response

    def initialize(attrs)
      @query = attrs[:query]
      @page  = attrs[:page]
    end

    def perform
      return [] unless query.present?
      request
    end

    private

    def request
      begin
        Flickr.photos.search(text: query, sort: :relevance, per_page: PER_PAGE, page: page)
      rescue => e
        # It would be great to call some kind of developers notification service (AppSignal, Honeybadger, etc.)
        errors[:api] = 'Flickr API is not available at the moment. Please try again later.'
      end
    end
  end
end
