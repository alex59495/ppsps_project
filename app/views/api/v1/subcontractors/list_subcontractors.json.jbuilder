json.array! @subcontractors do |subcontractor|
  json.extract! subcontractor, :id, :name, :work, :address, :responsible_name, :responsible_phone, :responsible_email
end
