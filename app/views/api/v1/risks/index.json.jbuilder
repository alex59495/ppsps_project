json.array! @risks do |risk|
  json.extract! risk, :id, :name
  json.categorie risk.risk_type.name
end
