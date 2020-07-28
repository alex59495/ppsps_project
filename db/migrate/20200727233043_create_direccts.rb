class CreateDireccts < ActiveRecord::Migration[6.0]
  def change
    create_table :direccts do |t|
      t.string :address
      t.string :phone
      t.string :fax

      t.timestamps
    end
  end
end
