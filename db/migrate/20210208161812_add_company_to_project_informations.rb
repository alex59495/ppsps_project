class AddCompanyToProjectInformations < ActiveRecord::Migration[6.0]
  def change
    add_reference :project_informations, :company, null: false, foreign_key: true
  end
end
