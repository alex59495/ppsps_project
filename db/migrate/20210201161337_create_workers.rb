class CreateWorkers < ActiveRecord::Migration[6.0]
  def change
    create_table :workers do |t|
      t.boolean :lifesaver
      t.boolean :conductor
      t.boolean :is_destroyed, default: false
      t.string :role
      t.string :phone
      t.string :email
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
