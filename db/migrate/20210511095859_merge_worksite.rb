class MergeWorksite < ActiveRecord::Migration[6.0]
  def change
    remove_column :ppsps, :worksite_id
    drop_table :worksites
    add_column :ppsps, :start_date, :date
    add_column :ppsps, :end_date, :date
    add_column :ppsps, :nature, :text
    add_column :ppsps, :num_responsible, :integer
    add_column :ppsps, :num_conductor, :integer
    add_column :ppsps, :num_worker, :integer
    add_column :ppsps, :address, :string
    add_column :ppsps, :timetable_summer, :boolean, default: false
    add_column :ppsps, :timetable_summer_start, :string
    add_column :ppsps, :timetable_summer_end, :string
    add_column :ppsps, :timetable_summer_start_friday, :string
    add_column :ppsps, :timetable_summer_end_friday, :string
    add_column :ppsps, :timetable_winter, :boolean, default: false
    add_column :ppsps, :timetable_winter_start, :string
    add_column :ppsps, :timetable_winter_end, :string
    add_column :ppsps, :timetable_winter_start_friday, :string
    add_column :ppsps, :timetable_winter_end_friday, :string
    add_column :ppsps, :electrical_site, :boolean, default: false
    add_column :ppsps, :water_site, :boolean, default: false
    add_column :ppsps, :plan, :boolean, default: false
    add_column :ppsps, :latitude, :float
    add_column :ppsps, :longitude, :float
    add_column :ppsps, :infirmary, :boolean, default: false
    add_column :ppsps, :infirmary_text, :text
  end
end
