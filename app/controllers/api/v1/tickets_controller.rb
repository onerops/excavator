class Api::V1::TicketsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]
  def create 
    process_and_respond( TicketOperation::Action::Create.new( params ) ) do |operation, result|
      render json: {success: true }, status: 201
    end
  end
end