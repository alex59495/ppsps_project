class CreateSelectedRisks < ActiveRecord::Migration[6.0]
  def change
    create_table :selected_risks do |t|
      t.references :ppsp, null: false, foreign_key: true
      t.references :risk, null: false, foreign_key: true

      t.timestamps
    end
  end
end
