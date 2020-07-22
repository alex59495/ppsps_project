class CreateAltitudeWorks < ActiveRecord::Migration[6.0]
  def change
    create_table :altitude_works do |t|
      t.string :name

      t.timestamps
    end
  end
end
