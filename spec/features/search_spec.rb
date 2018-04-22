# frozen_string_literal: true

require 'rails_helper'

feature 'Search', :js do
  describe 'Index page' do
    let(:api_key) { Rails.application.credentials.flickr[:key] }
    let(:query)   { 'Bangkok' }

    before do
      Flickr.configure { |c| c.api_key = api_key }
      VCR.use_cassette cassette do
        visit search_index_path(query: query)
      end
    end

    context 'When the query is empty' do
      let(:query)    { nil }
      let(:cassette) { 'empty_search' }

      it 'shows an error message' do
        expect(page.find('h2')).to have_content('Sorry, nothing found for your request')
      end
      it 'shows no results' do
        expect(page).to have_no_css('#results')
      end
    end

    context 'When API erorr happens' do
      let(:api_key)  { 31337 }
      let(:cassette) { 'api_error' }

      it 'shows an error message' do
        expect(page.find('h2')).to have_content('Flickr API is not available at the moment. Please try again later.')
      end
      it 'shows no results' do
        expect(page).to have_no_css('#results')
      end
    end

    context 'When everything is fine' do
      let(:cassette) { 'bangkok_search' }

      it 'has proper page title' do
        expect(page.find('h2')).to have_content('Search results')
      end
      it 'displays the number of found photos' do
        expect(page.find('.columns')).to have_content('2,868,638 photos found')
      end
      it 'has results block' do
        expect(page).to have_css('#results')
      end
      it 'renders photos' do
        expect(page.find('#results').all('img').count).to eq 50
      end
      it 'has pagination' do
        expect(page).to have_css('.pagination')
      end

      scenario 'click photo link' do
        page.find('#results').all('.preview > a').first.click
        expect(page).to have_current_path('/photos/25700967@N05/4468378065')
      end

      scenario 'click next page' do
        VCR.use_cassette 'bangkok_search_2' do
          page.find('.pagination-next').first('a').click
        end

        expect(page).to have_current_path(search_index_path(query: 'Bangkok', page: 2))
        expect(page.find('h2')).to have_content('Search results')
      end
    end
  end
end
