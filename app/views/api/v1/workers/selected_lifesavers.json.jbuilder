json.array! @lifesavers do |lifesaver|
  json.extract! lifesaver, :id, :first_name, :last_name, :conductor, :lifesaver
end
