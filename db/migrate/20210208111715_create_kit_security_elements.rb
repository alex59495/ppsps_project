class CreateKitSecurityElements < ActiveRecord::Migration[6.0]
  def change
    create_table :kit_security_elements do |t|
      t.references :company, null: false, foreign_key: true
      t.string :name
      t.integer :number

      t.timestamps
    end
  end
end
