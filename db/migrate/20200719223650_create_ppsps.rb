class CreatePpsps < ActiveRecord::Migration[6.0]
  def change
    create_table :ppsps do |t|
      t.timestamps
    end
  end
end
