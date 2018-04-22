# frozen_string_literal: true

class SearchController < ApplicationController
  def index
    render :index, locals: Flickr::SearchService.(params)
  end
end
