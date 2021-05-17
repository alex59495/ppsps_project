class MergeProjectInformation < ActiveRecord::Migration[6.0]
  def change
    remove_column :ppsps, :project_information_id
    drop_table :project_informations
    add_column :ppsps, :reference, :string
    add_column :ppsps, :name, :string
    add_reference :ppsps, :responsible, foreign_key: { to_table: :workers }
    add_reference :ppsps, :team_manager, foreign_key: { to_table: :workers }
    add_reference :ppsps, :site_manager, foreign_key: { to_table: :workers }
  end
end
