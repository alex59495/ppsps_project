class CreateSelectedAltitudes < ActiveRecord::Migration[6.0]
  def change
    create_table :selected_altitudes do |t|
      t.references :altitude_work
      t.references :ppsp

      t.timestamps
    end
  end
end
