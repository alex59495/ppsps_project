class CreateProjectInformations < ActiveRecord::Migration[6.0]
  def change
    create_table :project_informations do |t|
      t.string :reference
      t.string :name
      t.timestamps
    end
  end
end
