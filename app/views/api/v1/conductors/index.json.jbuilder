json.array! @conductors do |conductor|
  json.extract! conductor, :id, :ppsp_id
  json.machine_category conductor.machine.machine_category.name
  json.machine_caces conductor.machine.caces
  json.machine_description conductor.machine.description
  json.worker_first_name conductor.worker.first_name
  json.worker_last_name conductor.worker.last_name
end
