# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProductErrorsValidator do
  describe '.call' do
    subject { described_class.call(product) }
    context 'when the product is present' do
      let(:product) { create(:product) }

      it 'returns nil' do
        expect(subject).to be_nil
      end
    end

    context 'when the product is not present' do
      let(:product) { nil }
      let(:expected_error) { ['Product not found!', :not_found] }

      it 'returns the expected error' do
        expect(subject).to eq(expected_error)
      end
    end

    context 'when the product has validation errors' do
      let(:product) { build(:product, price: -1) }
      let(:expected_error) { ['Price must be greater than or equal to 0', :unprocessable_entity] }
      before { product.valid? }

      it 'returns the expected error' do
        expect(subject).to eq(expected_error)
      end
    end
  end
end
