# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProductService, type: :service do
  describe '.call' do
    let!(:products) { create_list(:product, 3) }

    it 'returns all products' do
      result = ProductService.call

      expect(result).not_to be_empty
      expect(result.size).to eq(3)
      expect(result).to eq(products)
    end
  end
end
