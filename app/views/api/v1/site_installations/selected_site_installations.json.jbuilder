json.array! @site_installations do |site_installation|
  json.extract! site_installation, :id, :name
end
