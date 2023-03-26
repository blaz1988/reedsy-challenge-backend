# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProductParamsParser, type: :parser do
  let(:item_params) { '1 MUG, 2 TSHIRT, 3 HOODIE' }
  let(:parser) { ProductParamsParser.new(item_params) }

  describe '#items' do
    it 'splits and trims the input string' do
      expect(parser.items).to eq(['1 MUG', '2 TSHIRT', '3 HOODIE'])
    end
  end

  describe '#product_codes' do
    it 'extracts the product codes from the items' do
      expect(parser.product_codes).to eq(%w[MUG TSHIRT HOODIE])
    end
  end

  describe '#error' do
    context 'when item_params are valid' do
      it 'returns nil' do
        expect(parser.error).to be_nil
      end
    end

    context 'when item_params are invalid' do
      let(:invalid_item_params) { 'WrongParams' }
      let(:invalid_parser) { ProductParamsParser.new(invalid_item_params) }

      it 'returns an error message' do
        expect(invalid_parser.error).to eq('Invalid params!')
      end
    end
  end
end
