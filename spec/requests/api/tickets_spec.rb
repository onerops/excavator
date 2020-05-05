require 'swagger_helper'

RSpec.describe 'api/v1/tickets', type: :request do

  path '/api/v1/tickets.json' do

    post 'Creates a ticket and excavator' do
      tags 'Tickets'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :request, in: :body, schema: {
        type: :object,
        properties: {
          RequestNumber: { type: :string },
          SequenceNumber: { type: :string },
          RequestType: { type: :string },
          DateTimes: { type: :object },
          Excavator: { type: :object },
          ServiceArea: { type: :object },
          ExcavationInfo: { type: :object }
        },
        required: [ 'RequestNumber', 'SequenceNumber', 'RequestType', 'DateTimes', 'Excavator', 'ServiceArea', 'ExcavationInfo' ]
      }

      response '201', 'ticket created' do
        schema type: :object,
          properties: {
            success: { type: :boolean },
          },
          required: [ 'success' ]


        let(:request) { JSON.load(load_file('valid_request.json')) }
        run_test!
      end

      response '422', 'invalid request' do

        schema type: :object,
          properties: {
            success: { type: :boolean },
            errors: { type: :object },
          },
          required: [ 'success' ]


        let(:request) { JSON.load(load_file('invalid_request.json')) }
        run_test!
      end

    end
  end


end
