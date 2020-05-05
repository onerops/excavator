class CreateTickets < ActiveRecord::Migration[6.0]
  def change
    create_table :tickets do |t|
      t.timestamps
      t.string :request_number, null:false
      t.integer :sequence_number, null:false
      t.string :request_type, null:false
      t.datetime :response_due_date_time, null:false
      t.string :primary_service_area_code, null:false
      t.string :additional_service_area_codes, null:false, array: true, default: []
      t.jsonb :polygon, null:false, default:[]
    end
  end
end
