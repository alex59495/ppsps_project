class CreatePensionInsurances < ActiveRecord::Migration[6.0]
  def change
    create_table :pension_insurances do |t|
      t.string :address
      t.string :phone
      t.string :fax
      t.references :company, foreign_key: true

      t.timestamps
    end
  end
end
