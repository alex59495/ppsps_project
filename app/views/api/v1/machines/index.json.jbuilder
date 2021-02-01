json.array! @machines do |machine|
  json.extract! machine, :id, :name
end
