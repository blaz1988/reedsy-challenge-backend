# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UpdateProductService do
  describe '#call' do
    let(:product) { create(:product) }
    let(:new_price) { 25.0 }
    let(:update_params) { { price: new_price } }

    subject { described_class.call(product, update_params) }

    it 'updates the product with the provided parameters' do
      expect { subject }.to change { product.reload.price }.to(new_price)
    end

    context 'when update params are invalid' do
      let(:invalid_update_params) { { price: -5.0 } }

      subject { described_class.call(product, invalid_update_params) }

      it 'does not update the product' do
        expect { subject }.not_to change { product.reload.price }
      end
    end
  end
end
