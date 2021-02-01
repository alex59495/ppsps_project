import React, {useState, useEffect} from 'react'
import MachinesList from './MachinesList'
import WorkersList from './WorkersList'
import SelectedElements from './SelectedElements'

const App = () => {
  const [machineId, serMachineid] = useState(null)
  const [workersId, setWorkersdId] = useState([])
  const [listMachines, setListMachines] = useState([])
  const [listWorkers, setListWorkers] = useState([])

  const url = window.location.protocol

  const fetchMachines = () => {
    fetch(`${url}/api/v1/machines`, {
      method: 'GET',
      'Content-Type': 'application/json'
    }).then(response => response.json()).then(data => setListMachines(data))
  }

  const fetcWorkers = () => {
    fetch(`${url}/api/v1/workers`, {
      method: 'GET',
      'Content-Type': 'application/json'
    }).then(response => response.json()).then(data => setListWorkers(data))
  }

  useEffect(() => {
    fetchMachines(),
    fetcWorkers()
  }, [])

  return (
    <div>
      <MachinesList listMachines={listMachines} />
      <WorkersList listWorkers={listWorkers}/>
      <Submit />
    </div>
  )
}

export default App
