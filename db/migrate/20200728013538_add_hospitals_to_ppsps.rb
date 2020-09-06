class AddHospitalsToPpsps < ActiveRecord::Migration[6.0]
  def change
    add_reference :ppsps, :hospital, null: false, foreign_key: true
  end
end
