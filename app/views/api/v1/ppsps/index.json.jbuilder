json.array! @ppsps do |ppsp|
  json.extract! ppsp, :id, :moa_id, :moe_id,
                :security_coordinator_id, :regional_committee_id, :pension_insurance_id,
                :direcct_id, :work_medecine_id, :demining_id, :sos_hand_id, :anti_poison_id, :hospital_id, :reference,
                :start_date, :end_date, :address
  json.user do
    json.id ppsp.user.id
    json.first_name ppsp.user.first_name
    json.last_name ppsp.user.last_name
    json.full_name ppsp.user.full_name
  end
end
