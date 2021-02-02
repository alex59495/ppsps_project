class RemovePpspFromSubcontractors < ActiveRecord::Migration[6.0]
  def change
    remove_reference :subcontractors, :ppsp, null: false, foreign_key: true
  end
end
