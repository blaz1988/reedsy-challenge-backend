# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::ProductsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: 'api/v1/products').to route_to('api/v1/products#index')
    end

    it 'routes to #show' do
      expect(get: 'api/v1/products/1').to route_to('api/v1/products#show', id: '1')
    end

    it 'routes to #update via PUT' do
      expect(put: 'api/v1/products/1').to route_to('api/v1/products#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: 'api/v1/products/1').to route_to('api/v1/products#update', id: '1')
    end

    it 'routes to #prices' do
      expect(get: 'api/v1/products/prices').to route_to('api/v1/products#prices')
    end

    it 'routes to #prices_with_discounts' do
      expect(get: 'api/v1/products/prices-with-discounts').to route_to('api/v1/products#prices_with_discounts')
    end
  end
end
