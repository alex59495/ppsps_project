class AddUsersToPpsps < ActiveRecord::Migration[6.0]
  def change
    add_reference :ppsps, :user, null: false, foreign_key: true
  end
end
