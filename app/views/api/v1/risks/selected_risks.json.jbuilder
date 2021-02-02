json.array! @risks do |risk|
  json.extract! risk, :id, :name
end
