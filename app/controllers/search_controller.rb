# frozen_string_literal: true

class SearchController < ApplicationController
  def index
    render :index, locals: Flickr::SearchService.(search_params)
  end

  private

  def search_params
    params.permit(:query, :page)
  end
end
