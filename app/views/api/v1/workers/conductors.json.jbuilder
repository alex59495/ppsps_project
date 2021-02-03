json.array! @workers do |worker|
  json.extract! worker, :id, :first_name, :last_name, :conductor, :lifesaver
end
