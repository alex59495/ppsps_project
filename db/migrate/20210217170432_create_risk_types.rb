class CreateRiskTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :risk_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
