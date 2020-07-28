class AddSubcontractorToPpsps < ActiveRecord::Migration[6.0]
  def change
    add_reference :ppsps, :subcontractor, null: true, foreign_key: true
  end
end
