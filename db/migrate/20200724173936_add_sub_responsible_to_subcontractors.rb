class AddSubResponsibleToSubcontractors < ActiveRecord::Migration[6.0]
  def change
    add_reference :subcontractors, :sub_responsible, null: false, foreign_key: true
  end
end
