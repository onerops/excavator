module TicketOperation
  module Action
    class Read
      include Operation::Base
      def perform 
        add_error!( :not_found, I18n.t("common.not_found") ) unless @model = Ticket.find_by(id: form.id)
        @model
      end
    end

    class List
      include Operation::Base
      def perform 
        @model = Ticket.page(form.page).order(id: :desc).includes(:excavator)
        @model.total_pages
      end
    end

    class Create
      include ::Operation::Base
      def perform
        with_transaction do 
          @model = Ticket.create!(
            request_number: form.request_number,
            sequence_number: form.sequence_number,
            request_type: form.request_type,
            response_due_date_time: form.date_times.response_due_date_time,
            primary_service_area_code: form.service_area.primary_service_area_code.sa_code[0],
            additional_service_area_codes: form.service_area.additional_service_area_codes.sa_code,
            polygon: form.excavation_info.digsite_info.polygon
          )
          Excavator.create!(
            ticket_id: @model.id,
            company_name: form.excavator.company_name,
            address: [form.excavator.state, form.excavator.city, form.excavator.address, form.excavator.zip].join(","),
            crew_on_site: form.excavator.crew_on_site,
          )
          return true
        end
      end
    end 


  end
end