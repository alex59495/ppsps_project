json.array! @conductors do |conductor|
  json.extract! conductor, :id
  json.machine_name conductor.machine.name
  json.worker_first_name conductor.worker.first_name
  json.worker_last_name conductor.worker.last_name
end
