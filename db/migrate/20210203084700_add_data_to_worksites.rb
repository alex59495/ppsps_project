class AddDataToWorksites < ActiveRecord::Migration[6.0]
  def change
    add_column :worksites, :latitude, :float
    add_column :worksites, :longitude, :float
  end
end
