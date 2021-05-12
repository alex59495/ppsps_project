class AddCompanyToPpsps < ActiveRecord::Migration[6.0]
  def change
    add_reference :ppsps, :company, null: false, foreign_key: true
  end
end
