class CreateWorksites < ActiveRecord::Migration[6.0]
  def change
    create_table :worksites do |t|
      t.date :start_date
      t.date :end_date
      t.text :nature
      t.integer :num_responsible
      t.integer :num_conductor
      t.integer :num_worker
      t.string :address
      t.boolean :timetable_summer
      t.string :timetable_summer_start
      t.string :timetable_summer_end
      t.string :timetable_summer_start_friday
      t.string :timetable_summer_end_friday
      t.boolean :timetable_winter
      t.string :timetable_winter_start
      t.string :timetable_winter_end
      t.string :timetable_winter_start_friday
      t.string :timetable_winter_end_friday
      t.boolean :electrical_site
      t.boolean :water_site
      t.boolean :plan

      t.timestamps
    end
  end
end
