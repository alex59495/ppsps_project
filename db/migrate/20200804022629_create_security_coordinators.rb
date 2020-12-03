class CreateSecurityCoordinators < ActiveRecord::Migration[6.0]
  def change
    create_table :security_coordinators do |t|
      t.string :name
      t.string :address
      t.string :representative
      t.string :phone
      t.string :email
      t.references :company, foreign_key: true

      t.timestamps
    end
  end
end
