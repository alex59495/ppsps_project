class AddAntiPoisonsToPpsps < ActiveRecord::Migration[6.0]
  def change
    add_reference :ppsps, :anti_poison, null: false, foreign_key: true
  end
end
