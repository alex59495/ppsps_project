json.array! @machines do |machine|
  json.extract! machine, :name
end