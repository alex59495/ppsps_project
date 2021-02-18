class AddMachineCategoryToMachine < ActiveRecord::Migration[6.0]
  def change
    add_reference :machines, :machine_category, null: false, foreign_key: true
  end
end
