FactoryBot.define do

  factory :excavator do
    id {100}
    ticket_id {100}
    company_name { "Company" }
    address  { "Some address" }
    crew_on_site { false }
  end

end