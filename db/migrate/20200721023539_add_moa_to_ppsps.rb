class AddMoaToPpsps < ActiveRecord::Migration[6.0]
  def change
    add_reference :ppsps, :moa, null: false, foreign_key: true
  end
end
