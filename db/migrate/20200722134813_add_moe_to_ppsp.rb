class AddMoeToPpsp < ActiveRecord::Migration[6.0]
  def change
    add_reference :ppsps, :moe, null: false, foreign_key: true
  end
end
