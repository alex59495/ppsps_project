class CreateWorksites < ActiveRecord::Migration[6.0]
  def change
    create_table :worksites do |t|
      t.date :start_date
      t.date :end_date
      t.string :nature
      t.integer :num_responsible
      t.integer :num_conductor
      t.integer :num_worker
      t.string :address
      t.string :timetable_start
      t.string :timetable_end
      t.boolean :electrical_site
      t.boolean :water_site
      t.boolean :plan

      t.timestamps
    end
  end
end
