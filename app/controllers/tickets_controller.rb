class TicketsController < ApplicationController
  
  def index 
    process_and_respond( TicketOperation::Action::List.new( params ) ) do |operation, result|
      render json: {success: true, total: result, items: ::ActiveModelSerializers::SerializableResource.new(operation.model, each_serializer: TicketSerializer::List ) }
    end
  end

  def show 
    process_and_respond( TicketOperation::Action::Read.new( params ) ) do |operation, result|
      render json: {success: true, item: TicketSerializer::Item.new(operation.model ) } 
    end
  end
end


