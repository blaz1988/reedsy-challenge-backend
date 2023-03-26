# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DiscountCalculatorService, type: :service do
  describe '.call' do
    subject { described_class.call(code, quantity, price) }

    context 'when the product is a TSHIRT' do
      let(:code) { 'TSHIRT' }
      let(:price) { 15.00 }

      context 'with a quantity less than 3' do
        let(:quantity) { 2 }

        it 'does not apply a discount' do
          expect(subject).to eq(15.00)
        end
      end

      context 'with a quantity of 3 or more' do
        let(:quantity) { 3 }

        it 'applies a 30% discount' do
          expect(subject).to eq(10.50)
        end
      end
    end

    context 'when the product is a MUG' do
      let(:code) { 'MUG' }
      let(:price) { 6.00 }

      context 'with a quantity between 10 and 19' do
        let(:quantity) { 10 }

        it 'applies a 2% discount' do
          expect(subject).to eq(5.88)
        end
      end

      context 'with a quantity between 20 and 29' do
        let(:quantity) { 20 }

        it 'applies a 4% discount' do
          expect(subject).to eq(5.76)
        end
      end

      context 'with a quantity of 150 or more' do
        let(:quantity) { 150 }

        it 'applies a 30% discount' do
          expect(subject).to be_within(0.001).of(4.20)
        end
      end

      context 'when the product is not MUG or TSHIRT' do
        let(:code) { 'HOODIE' }
        let(:price) { 20.00 }
        let(:quantity) { 1 }

        it 'does not apply a discount' do
          expect(subject).to eq(20.00)
        end
      end
    end
  end
end
