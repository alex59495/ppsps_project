class AddRiskTypeToRisk < ActiveRecord::Migration[6.0]
  def change
    add_reference :risks, :risk_type, null: false, foreign_key: true
  end
end
