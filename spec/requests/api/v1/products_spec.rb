# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Products', type: :request do
  let!(:products) { create_list(:product, 3) }
  let(:product_id) { products.first.id }

  describe 'GET /api/v1/products' do
    before { get '/api/v1/products' }

    it 'returns a success response' do
      expect(response).to have_http_status(:success)
    end

    it 'returns a list of products' do
      expect(json).not_to be_empty
      expect(json.size).to eq(3)
    end
  end

  describe 'GET /api/v1/products/:id' do
    before { get "/api/v1/products/#{product_id}" }

    it 'returns a success response' do
      expect(response).to have_http_status(:success)
    end

    it 'returns the requested product' do
      expect(json).not_to be_empty
      expect(json['id']).to eq(product_id)
    end
  end

  describe 'PATCH /api/v1/products/:id' do
    let(:valid_attributes) { { product: { price: 100.0 } } }

    context 'when the user is authenticated' do
      before do
        patch "/api/v1/products/#{product_id}", params: valid_attributes,
                                                headers: { 'Authorization': ENV['AUTH_TOKEN'] }
      end

      it 'updates the product' do
        expect(response).to have_http_status(:success)
        expect(json['price']).to eq('100.0')
      end
    end

    context 'when the user is not authenticated' do
      before { patch "/api/v1/products/#{product_id}", params: valid_attributes }

      it 'returns an unauthorized response' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'GET /api/v1/products/prices' do
    let!(:mug) { create(:product, code: 'MUG', price: 6.0) }
    let!(:tshirt) { create(:product, code: 'TSHIRT', price: 15.0) }
    let!(:hoodie) { create(:product, code: 'HOODIE', price: 20.0) }
    let(:items) { '1 MUG, 1 TSHIRT, 1 HOODIE' }

    context 'when items parameter is valid' do
      before { get "/api/v1/products/prices?items=#{URI.encode_www_form_component(items)}" }

      it 'returns a success response' do
        expect(response).to have_http_status(:success)
      end

      it 'returns the total price for the given list of items' do
        expect(json).not_to be_empty
        expect(json['total']).to eq('41.0')
      end
    end

    context 'when items parameter is invalid' do
      let(:invalid_items) { '1MUG, 1TSHIRT, 1HOODIE' }

      before { get "/api/v1/products/prices?items=#{URI.encode_www_form_component(invalid_items)}" }

      it 'returns an unprocessable entity response' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns an error message' do
        expect(json).not_to be_empty
        expect(json['error']).to eq('Invalid params!')
      end
    end
  end

  describe 'GET /api/v1/products/prices-with-discounts' do
    let!(:mug) { create(:product, code: 'MUG', price: 6.0) }
    let!(:tshirt) { create(:product, code: 'TSHIRT', price: 15.0) }
    let!(:hoodie) { create(:product, code: 'HOODIE', price: 20.0) }
    let(:items) { '45 MUG, 3 TSHIRT' }

    context 'when items parameter is valid' do
      before { get "/api/v1/products/prices-with-discounts?items=#{URI.encode_www_form_component(items)}" }

      it 'returns a success response' do
        expect(response).to have_http_status(:success)
      end

      it 'returns the total price with discounts for the given list of items' do
        expect(json).not_to be_empty
        expect(json['total']).to eq('279.9')
      end
    end

    context 'when items parameter is invalid' do
      let(:invalid_items) { '1MUG, 1TSHIRT, 1HOODIE' }

      before { get "/api/v1/products/prices-with-discounts?items=#{URI.encode_www_form_component(invalid_items)}" }

      it 'returns an unprocessable entity response' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns an error message' do
        expect(json).not_to be_empty
        expect(json['error']).to eq('Invalid params!')
      end
    end
  end

  def json
    JSON.parse(response.body)
  end
end
