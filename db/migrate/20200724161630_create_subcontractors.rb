class CreateSubcontractors < ActiveRecord::Migration[6.0]
  def change
    create_table :subcontractors do |t|
      t.string :name
      t.string :address
      t.string :work
      t.string :responsible_name
      t.string :responsible_phone
      t.string :responsible_email
      t.timestamps
    end
  end
end
