class CreateConductors < ActiveRecord::Migration[6.0]
  def change
    create_table :conductors do |t|
      t.references :ppsp, null: true, foreign_key: true
      t.references :machine, null: false, foreign_key: true
      t.references :worker, null: false, foreign_key: true

      t.timestamps
    end
  end
end
