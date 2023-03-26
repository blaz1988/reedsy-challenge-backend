# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AuthenticationService do
  describe '.authenticate?' do
    let(:mock_request) { instance_double(ActionDispatch::Request) }

    context 'when token is valid' do
      it 'returns true' do
        allow(mock_request).to receive(:headers).and_return({ 'Authorization' => ENV['AUTH_TOKEN'] })

        expect(AuthenticationService.authenticate?(mock_request)).to be_truthy
      end
    end

    context 'when token is missing' do
      it 'returns false' do
        allow(mock_request).to receive(:headers).and_return({})

        expect(AuthenticationService.authenticate?(mock_request)).to be_falsey
      end
    end

    context 'when token is invalid' do
      it 'returns false' do
        allow(mock_request).to receive(:headers).and_return({ 'Authorization' => 'invalid_token' })

        expect(AuthenticationService.authenticate?(mock_request)).to be_falsey
      end
    end
  end
end
