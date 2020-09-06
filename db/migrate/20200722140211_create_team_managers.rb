class CreateTeamManagers < ActiveRecord::Migration[6.0]
  def change
    create_table :team_managers do |t|
      t.string :name
      t.string :phone
      t.string :email

      t.timestamps
    end
  end
end
