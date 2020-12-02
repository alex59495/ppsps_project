class CreateRegionalComittees < ActiveRecord::Migration[6.0]
  def change
    create_table :regional_committees do |t|
      t.string :name
      t.string :address
      t.string :phone
      t.string :fax
      t.references :company, foreign_key: true

      t.timestamps
    end
  end
end
