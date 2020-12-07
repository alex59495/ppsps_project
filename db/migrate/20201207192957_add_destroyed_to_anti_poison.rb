class AddDestroyedToAntiPoison < ActiveRecord::Migration[6.0]
  def change
    add_column :anti_poisons, :is_destroyed, :boolean, default: false
    add_column :work_medecines, :is_destroyed, :boolean, default: false
    add_column :deminings, :is_destroyed, :boolean, default: false
    add_column :direccts, :is_destroyed, :boolean, default: false
    add_column :hospitals, :is_destroyed, :boolean, default: false
    add_column :moas, :is_destroyed, :boolean, default: false
    add_column :moes, :is_destroyed, :boolean, default: false
    add_column :pension_insurances, :is_destroyed, :boolean, default: false
    add_column :regional_committees, :is_destroyed, :boolean, default: false
    add_column :sos_hands, :is_destroyed, :boolean, default: false
    add_column :security_coordinators, :is_destroyed, :boolean, default: false
  end
end
