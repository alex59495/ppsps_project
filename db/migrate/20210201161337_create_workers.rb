class CreateWorkers < ActiveRecord::Migration[6.0]
  def change
    create_table :workers do |t|
      t.boolean :lifesaver
      t.boolean :conductor
      t.boolean :is_destroyed
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
