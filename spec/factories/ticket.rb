FactoryBot.define do
  factory :ticket do
    id {100}
    request_number { "some_number" }
    sequence_number  { 1 }
    request_type { "some_type" }
    response_due_date_time { DateTime.now }
    primary_service_area_code { "code" }
    additional_service_area_codes { ["code"] }
    polygon { [{lat:0,lng:0}] }

    after(:create) do |ticket, evaluator|
      create(:excavator, ticket: ticket)
    end

  end
end
