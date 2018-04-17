# frozen_string_literal: true

require 'rails_helper'

describe Flickr::SearchService do
  subject { Flickr::SearchService.(query) }

  context 'with valid API key' do
    context 'default query' do
      let(:query) { 'Bangkok' }

      it 'returns search results' do
        expect(subject.length).to eq(50)
      end
      it 'results have expected attributes' do
        response = subject.first
        %i[id title url].each { |key| expect(response.send(key).present?).to be_truthy }
      end
    end

    context 'empty query' do
      let(:query) { '' }
      it 'raises an exception' do
        expect { subject }.to raise_error(ArgumentError, 'Search query can`t be empty')
      end
    end
  end
end
