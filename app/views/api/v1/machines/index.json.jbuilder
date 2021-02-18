json.array! @machines do |machine|
  json.extract! machine, :id, :caces, :description, :image
  json.category machine.machine_category
end
