# frozen_string_literal: true

require 'rails_helper'

describe Flickr::SearchService do
  context 'with valid API key' do
    context 'default query' do
      subject { Flickr::SearchService.('Bangkok') }

      it 'returns search results' do
        expect(subject).to eq({})
      end
    end
  end
end
