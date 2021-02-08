class AddResponsibleIdToProjectInformations < ActiveRecord::Migration[6.0]
  def change
    add_column :project_informations, :responsible_id, :integer
    add_column :project_informations, :team_manager_id, :integer
    add_column :project_informations, :site_manager_id, :integer
  end
end
