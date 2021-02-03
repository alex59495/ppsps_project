class CreateSelectedLifesavers < ActiveRecord::Migration[6.0]
  def change
    create_table :selected_lifesavers do |t|
      t.references :ppsp, null: false, foreign_key: true
      t.references :worker, null: false, foreign_key: true

      t.timestamps
    end
  end
end
