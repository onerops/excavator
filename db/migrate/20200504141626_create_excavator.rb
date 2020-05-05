class CreateExcavator < ActiveRecord::Migration[6.0]
  def change
    create_table :excavators do |t|
      t.timestamps
      t.string :company_name, null:false
      t.string :address, null:false
      t.boolean :crew_on_site
      t.integer :ticket_id, null:false, index: true
    end
  end
end
