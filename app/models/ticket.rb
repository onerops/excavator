class Ticket < ApplicationRecord
  has_one :excavator, dependent: :destroy

  delegate :company_name, to: :excavator, prefix: true
  delegate :address, to: :excavator, prefix: true
end