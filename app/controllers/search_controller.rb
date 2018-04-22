# frozen_string_literal: true

class SearchController < ApplicationController
  def index
    search = Flickr::Search.new(search_params).perform
    locals = {
      results: search.success? ? search.result : [],
      errors:  search.fail?    ? search.errors : []
    }

    render :index, locals: locals
  end

  private

  def search_params
    params.permit(:query, :page)
  end
end
