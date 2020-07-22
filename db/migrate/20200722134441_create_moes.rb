class CreateMoes < ActiveRecord::Migration[6.0]
  def change
    create_table :moes do |t|
      t.string :name
      t.string :address
      t.string :representative
      t.string :phone
      t.string :email

      t.timestamps
    end
  end
end
