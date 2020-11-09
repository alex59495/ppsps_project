class AddPpspToSubcontractors < ActiveRecord::Migration[6.0]
  def change
    add_reference :subcontractors, :ppsp, null: false, foreign_key: true
  end
end
