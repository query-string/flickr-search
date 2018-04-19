# frozen_string_literal: true

class SearchController < ApplicationController
  def index
    render :index, locals: {
      results: params[:query].present? ? Flickr::SearchService.(params[:query]) : []
    }
  end
end
