class CreatePpsps < ActiveRecord::Migration[6.0]
  def change
    create_table :ppsps do |t|
      t.string :address
      t.date :start
      t.date :end
      t.string :nature
      t.string :workforce

      t.timestamps
    end
  end
end
