class CreateMachines < ActiveRecord::Migration[6.0]
  def change
    create_table :machines do |t|
      t.string :category
      t.string :caces
      t.text :description
      

      t.timestamps
    end
  end
end
