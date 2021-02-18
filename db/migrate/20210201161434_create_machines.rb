class CreateMachines < ActiveRecord::Migration[6.0]
  def change
    create_table :machines do |t|
      t.string :caces
      t.text :description
      t.string :image
      

      t.timestamps
    end
  end
end
