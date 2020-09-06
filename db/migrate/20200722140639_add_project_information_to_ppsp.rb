class AddProjectInformationToPpsp < ActiveRecord::Migration[6.0]
  def change
    add_reference :ppsps, :project_information, null: false, foreign_key: true
  end
end
