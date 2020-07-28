class AddSiteManagerToProjectInformation < ActiveRecord::Migration[6.0]
  def change
    add_reference :project_informations, :site_manager, null: false, foreign_key: true
  end
end