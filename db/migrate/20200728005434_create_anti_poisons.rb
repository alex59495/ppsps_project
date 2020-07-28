class CreateAntiPoisons < ActiveRecord::Migration[6.0]
  def change
    create_table :anti_poisons do |t|
      t.string :name
      t.string :address
      t.string :phone

      t.timestamps
    end
  end
end
