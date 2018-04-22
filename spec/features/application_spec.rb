# frozen_string_literal: true

require 'rails_helper'

feature 'Landing page', :js do
  describe 'Search form' do
    before { visit root_path }

    scenario 'Type request and press submit button' do
      page.find('#query').set('Bangkok')
      page.find_button('Search').click
      expect(page).to have_current_path(search_index_path(query: 'Bangkok'))
    end
  end
end
