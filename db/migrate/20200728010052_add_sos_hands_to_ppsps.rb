class AddSosHandsToPpsps < ActiveRecord::Migration[6.0]
  def change
    add_reference :ppsps, :sos_hand, null: false, foreign_key: true
  end
end
