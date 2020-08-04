class AddSecurityCoordinatorToPpsp < ActiveRecord::Migration[6.0]
  def change
    add_reference :ppsps, :security_coordinator, foreign_key: true
  end
end
