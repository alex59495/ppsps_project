class AddTeamManagerToProjectInformation < ActiveRecord::Migration[6.0]
  def change
    add_reference :project_informations, :team_manager, null: false, foreign_key: true
  end
end
