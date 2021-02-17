class AddNameToWorkers < ActiveRecord::Migration[6.0]
  def change
    add_column :workers, :first_name, :string
    add_column :workers, :last_name, :string
  end
end
