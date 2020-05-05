module TicketOperation
  module Validation

    class List 
      include ::Validation::Base
      attribute :page, Integer, default: 1
    end

    class Read 
      include ::Validation::Base
      attribute :id, Integer
      validates :id, presence: true
    end


    class Excavator 
      include ::Validation::Base
      attribute :company_name, String
      attribute :address, String
      attribute :city, String
      attribute :state, String
      attribute :zip, String
      attribute :crew_on_site, Boolean, default: false

      validates :company_name, :address, :city, :state, :zip, presence: true

    end

    class DateTimeInfo
      include ::Validation::Base
      attribute :response_due_date_time, DateTime
      validates :response_due_date_time, presence: true
      validates_datetime :response_due_date_time
    end

    class ServiceAreaCode
      include ::Validation::Base
      attribute :sa_code, Array[String]
      validates :sa_code, presence: true
    end

    class ServiceArea
      include ::Validation::Base
      attribute :primary_service_area_code, ServiceAreaCode
      attribute :additional_service_area_codes, ServiceAreaCode

      validates :primary_service_area_code, :additional_service_area_codes,  presence: true

      before_validation do |form|
        errors.add(:primary_service_area_code, I18n.t("common.not_valid")) if form.primary_service_area_code && !form.primary_service_area_code.valid?
        errors.add(:additional_service_area_codes, I18n.t("common.not_valid")) if form.additional_service_area_codes && !form.additional_service_area_codes.valid?
      end
    end

    class Point 
      include ::Validation::Base
      attribute :lat, Float
      attribute :lng, Float
      validates :lng,:lng, presence: true, numericality: { other_than: 0.0 }
    end

    class DigsiteInfo
      include ::Validation::Base
      attribute :well_known_text, String
      attribute :polygon, Array[Point]
      validates :well_known_text, presence: true
      validate :polygon_presence
      def polygon_presence
        matched = self.well_known_text.match(/\(\((.*?)\)/)
        errors.add(:well_known_text, I18n.t("common.not_valid")) unless 2 == matched.length
        matched[1].split(",").each do |r| 
          lat, lng = r.split(" ") 
          polygon = Point.new(lat: lat, lng: lng)
          errors.add(:well_known_text, I18n.t("common.not_valid")) unless polygon.valid?
          self.polygon << polygon
        end
        errors.add(:well_known_text, I18n.t("common.not_valid")) unless self.polygon.any?
      end
    end

    class ExcavationInfo
      include ::Validation::Base
      attribute :digsite_info, DigsiteInfo
      validates :digsite_info, presence: true

      before_validation do |form|
        errors.add(:digsite_info, I18n.t("common.not_valid")) if form.digsite_info && !form.digsite_info.valid?
      end
    end


    class Create
      include ::Validation::Base

      attribute :request_number, String
      attribute :sequence_number, Integer
      attribute :request_type, String
      attribute :excavator, Excavator
      attribute :date_times, DateTimeInfo
      attribute :service_area, ServiceArea
      attribute :excavation_info, ExcavationInfo

      validates :request_number, :sequence_number, :request_type, :date_times, :service_area, :excavation_info, :excavator, presence: true

      before_validation do |form|
        errors.add(:date_times, I18n.t("common.not_valid") ) if form.date_times && !form.date_times.valid?
        errors.add(:service_area, I18n.t("common.not_valid") ) if form.service_area && !form.service_area.valid?
        errors.add(:excavation_info, I18n.t("common.not_valid") ) if form.excavation_info && !form.excavation_info.valid?
        errors.add(:excavator, I18n.t("common.not_valid") ) if form.excavator && !form.excavator.valid?
      end
    end


  end
end

