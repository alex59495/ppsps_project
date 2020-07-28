class CreateRegionalComittees < ActiveRecord::Migration[6.0]
  def change
    create_table :regional_committees do |t|
      t.string :name
      t.string :address
      t.string :phone
      t.string :fax

      t.timestamps
    end
  end
end
