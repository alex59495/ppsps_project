class AddWorksiteToPpsp < ActiveRecord::Migration[6.0]
  def change
    add_reference :ppsps, :worksite, null: false, foreign_key: true
  end
end
