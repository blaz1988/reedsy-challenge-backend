# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PriceCalculatorService, type: :service do
  let!(:mug) { create(:product, code: 'MUG', price: 6.0) }
  let!(:tshirt) { create(:product, code: 'TSHIRT', price: 15.0) }
  let!(:hoodie) { create(:product, code: 'HOODIE', price: 20.0) }

  describe '.call' do
    subject { described_class.call(parser) }

    let(:parser) { ProductParamsParser.new(item_params) }

    context 'scenario 1' do
      let(:item_params) { '1 MUG, 1 TSHIRT, 1 HOODIE' }

      it 'calculates the total price correctly' do
        expect(subject).to eq(41.0)
      end
    end

    context 'scenario 2' do
      let(:item_params) { '2 MUG, 1 TSHIRT' }

      it 'calculates the total price correctly' do
        expect(subject).to eq(27.0)
      end
    end

    context 'scenario 3' do
      let(:item_params) { '3 MUG, 1 TSHIRT' }

      it 'calculates the total price correctly' do
        expect(subject).to eq(33.0)
      end
    end

    context 'scenario 4' do
      let(:item_params) { '2 MUG, 4 TSHIRT, 1 HOODIE' }

      it 'calculates the total price correctly' do
        expect(subject).to eq(92.0)
      end
    end

    context 'when some products are not found' do
      let(:item_params) { '1 MUG, 1 TSHIRT, 1 HOODIE, 1 INVALID' }

      it 'calculates the total price for the found products only' do
        expect(subject).to eq(41.0)
      end
    end

    context 'when no products are found' do
      let(:item_params) { '1 INVALID1, 1 INVALID2' }

      it 'returns 0 as the total price' do
        expect(subject).to eq(0)
      end
    end
  end
end
