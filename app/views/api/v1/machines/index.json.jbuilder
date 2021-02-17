json.array! @machines do |machine|
  json.extract! machine, :id, :category, :caces, :description
end
