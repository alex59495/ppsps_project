class CreateWorksites < ActiveRecord::Migration[6.0]
  def change
    create_table :worksites do |t|
      t.date :start_date
      t.date :end_date
      t.string :nature
      t.string :workforce
      t.string :address
      t.string :timetable_start
      t.string :timetable_end
      t.boolean :electrical

      t.timestamps
    end
  end
end
