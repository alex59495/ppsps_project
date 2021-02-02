class AddDestroyedToSubcontractor < ActiveRecord::Migration[6.0]
  def change
    add_column :subcontractors, :is_destroyed, :boolean, default: false
  end
end
