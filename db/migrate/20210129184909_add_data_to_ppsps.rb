class AddDataToPpsps < ActiveRecord::Migration[6.0]
  def change
    add_column :ppsps, :latitude, :float
    add_column :ppsps, :longitude, :float
  end
end
