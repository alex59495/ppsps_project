class AllowNullValuePpsp < ActiveRecord::Migration[6.0]
  def change
    change_column :ppsps, :user_id, :integer, null: true
    change_column :ppsps, :moe_id, :integer, null: true
    change_column :ppsps, :moa_id, :integer, null: true
    change_column :ppsps, :project_information_id, :integer, null: true
    change_column :ppsps, :direcct_id, :integer, null: true
    change_column :ppsps, :regional_committee_id, :integer, null: true
    change_column :ppsps, :pension_insurance_id, :integer, null: true
    change_column :ppsps, :work_medecine_id, :integer, null: true
    change_column :ppsps, :demining_id, :integer, null: true
    change_column :ppsps, :sos_hand_id, :integer, null: true
    change_column :ppsps, :anti_poison_id, :integer, null: true
    change_column :ppsps, :hospital_id, :integer, null: true
    change_column :ppsps, :security_coordinator_id, :integer, null: true
    change_column :ppsps, :worksite_id, :integer, null: true
  end
end
