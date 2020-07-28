class AddDirecctToPpsps < ActiveRecord::Migration[6.0]
  def change
    add_reference :ppsps, :direcct, null: false, foreign_key: true
  end
end
