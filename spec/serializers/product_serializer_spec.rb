# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProductSerializer, type: :serializer do
  let(:product) { build(:product) }
  let(:serializer) { described_class.new(product) }

  describe 'attributes' do
    subject { serializer.attributes }

    it { is_expected.to include(:id) }
    it { is_expected.to include(:code) }
    it { is_expected.to include(:name) }
    it { is_expected.to include(:price) }
    it { is_expected.to include(:status) }
  end

  describe 'status attribute' do
    subject { serializer.attributes[:status] }

    it { is_expected.to eq(:unprocessable_entity) }
  end
end
