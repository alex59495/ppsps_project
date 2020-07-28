class AddDeminingsToPpsps < ActiveRecord::Migration[6.0]
  def change
    add_reference :ppsps, :demining, null: false, foreign_key: true
  end
end
