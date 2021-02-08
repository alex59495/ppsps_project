json.array! @categories do |machine|
  json.extract! machine, :category
end
