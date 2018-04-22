# frozen_string_literal: true

module Flickr
  class SearchService < Service
    PER_PAGE = 50

    attr_reader :query, :page, :response

    def call(attrs)
      @query    = attrs[:query]
      @page     = attrs[:page]
      @response = { results: [], errors: [] }

      return response if query.empty?
      request
    end

    private

    def request
      begin
        response[:results] = Flickr.photos.search(text: query, sort: :relevance, per_page: PER_PAGE, page: page)
      rescue e
        # It would be great to call some kind of developers notification service (AppSignal, Honeybadger, etc.)
        response[:errors] << 'Flickr API is not available at the moment. Please try again later.'
      end

      response
    end
  end
end
