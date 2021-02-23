json.array! @machines do |machine|
  json.extract! machine, :id, :caces, :description, :image
  json.category do
    json.name machine.machine_category.name
  end
end
