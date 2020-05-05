module TicketSerializer

  class Excavator < ActiveModel::Serializer
    attributes :id
  end

  class List < ActiveModel::Serializer
    attributes :id, :request_number, :sequence_number, :request_type, :response_due_date_time, :primary_service_area_code, :excavator_company_name, :excavator_address
  end

  class Item < List 
    attributes :polygon, :additional_service_area_codes
  end

end
