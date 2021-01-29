class AddCompanyToSubcontractor < ActiveRecord::Migration[6.0]
  def change
    add_reference :subcontractors, :company, null: false, foreign_key: true
  end
end
