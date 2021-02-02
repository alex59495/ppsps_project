class CreateSelectedSubcontractors < ActiveRecord::Migration[6.0]
  def change
    create_table :selected_subcontractors do |t|
      t.references :ppsp, null: false, foreign_key: true
      t.references :subcontractor, null: false, foreign_key: true

      t.timestamps
    end
  end
end
