# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Error, type: :object do
  let(:error) do
    Error.new({
                "code": '422',
                "status": Rack::Utils::HTTP_STATUS_CODES[422],
                "message": [
                  'Email has already been taken'
                ]
              })
  end

  describe 'Instantiation' do
    it 'returns code' do
      expect(error.code).to be_an String
      expect(error.code).to eq '422'
    end

    it 'returns status' do
      expect(error.status).to be_an String
      expect(error.status).to eq 'Unprocessable Entity'
    end

    it 'returns message' do
      expect(error.message).to be_an Array
      expect(error.message[0]).to eq 'Email has already been taken'
    end
  end
end
