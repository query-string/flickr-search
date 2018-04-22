# frozen_string_literal: true
require 'rails_helper'

describe Flickr::Search do
  let(:attrs)   { { query: 'Bangkok' } }
  let(:results) { subject.result }

  subject do
    VCR.use_cassette cassette do
      Flickr::Search.new(attrs).perform
    end
  end

  context 'with valid attributes' do

    context 'default query' do
      let(:cassette) { 'bangkok_search' }

      it 'returns no errors' do
        expect(subject.fail?).to be_falsy
      end
      it 'returns search results' do
        expect(results.length).to eq 50
      end
      it 'results have expected attributes' do
        %i[id title url].each { |key| expect(results.first.send(key).present?).to be_truthy }
      end
    end

    context 'default query with pagination' do
      let(:attrs) { { query: 'Bangkok', page: 2 } }
      let(:cassette) { 'bangkok_search_2' }

      it 'returns search results' do
        expect(results.length).to eq 50
      end
      it 'returns current page number' do
        expect(results.current_page).to eq 2
      end
    end
  end

  context 'with invalid attributes' do
    let(:cassette) { 'empty_search' }

    context 'no attributes' do
      let(:attrs) { {} }
      it 'returns empty results' do
        expect(results).to be_empty
      end
    end

    context 'empty query' do
      let(:attrs) { { query: nil } }
      it 'returns empty results' do
        expect(results).to be_empty
      end
    end
  end

  context 'with broken API' do
    before { Flickr.configure { |c| c.api_key = 31337 } }
    let(:cassette) { 'api_error' }

    it 'returns no results' do
      expect(subject.success?).to be_falsy
    end
    it 'returns errors array' do
      expect(subject.errors).to eq(api: 'Flickr API is not available at the moment. Please try again later.')
    end
  end
end
