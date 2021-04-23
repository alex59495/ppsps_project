import React, {useState, useEffect} from 'react'
import axios from 'axios'


import ListCategory from './ListCategory'
import ListMachines from './ListMachines'
import WorkersList from './WorkersList'
import SavedVehicules from './SavedVehicules'

const App = () => {
  const [category, setCategory] = useState(null)
  const [workersId, setWorkersId] = useState([])
  const [machineId, setMachineId] = useState([])
// Form lists
  const [listCategory, setlistCategory] = useState([])
  const [listMachines, setListMachines] = useState([])
  const [listWorkers, setListWorkers] = useState([])

  const [showListCategory, setShowListCategory] = useState(true)  
  const [showListMachines, setShowListMachines] = useState(false)
  const [showListWorkers, setShowListWorkers] = useState(false)

// List des éléments déjà selectionés par l'utilisateur
  const [listSelected, setListSelected] = useState([])

// Add a trigger to reactivate the app when creating a new conductor
  const [trigger, setTrigger] = useState(0)

  const url = window.location.protocol

  const ppspsId = document.getElementById('conductors-form-react').dataset
  .ppsps_id;

// DOM
  const btnSubmitCategories = document.getElementById('submit-category')
  const formListCategory = document.querySelector('.form-list-categories')
  const formListMachines = document.querySelector('.form-list-machines')
  const formWorkers = document.querySelector('.checkboxes-workers')

  const clearState = () => {
    setCategory(null);
    setWorkersId([]);
    setMachineId([]);
    setlistCategory([]);
    setListWorkers([]);
    setListSelected([]);
    setListMachines([]);
  }

  const handleReset = () => {
    console.log('reset');
    setShowListCategory(true)
    setShowListMachines(false)
    setShowListWorkers(false)

    clearState();
  }

  // Category's logic
  const fetchCategories = () => {
    fetch(`${url}/api/v1/machines/categories?ppsps_id=${ppspsId}`, {
      method: 'GET',
      'Content-Type': 'application/json'
    }).then(response => response.json()).then(data => {
      const arrayCategory = data.map(machine => {
        return machine.category
      })
      setlistCategory(arrayCategory)
    })
  }

  const fetchMachines = () => {
    fetch(`${url}/api/v1/machines?ppsps_id=${ppspsId}&category=${category}`, {
      method: 'GET',
      'Content-Type': 'application/json'
    })
      .then(response => response.json())
      .then(data => setListMachines(data))
  }


  const handleSubmitCategory = async (e) => {
    e.preventDefault()
    await fetchMachines()
    setShowListCategory(false)
    setShowListMachines(true)
    // Clean the inputs of the form
    formListCategory.reset()
    btnSubmitCategories.disabled = true
  }

  const selectCategory = (e) => {
    setCategory(e.currentTarget.value)
    btnSubmitCategories.disabled = false
  }


// Machines' logic
  const handleSubmitMachine = async (e) => {
    e.preventDefault()
    await fetchWorkers()
    setShowListMachines(false)
    setShowListWorkers(true)
    // Clean the inputs of the form
    formListMachines.reset()
    btnSubmitCategories.disabled = true
  }

  const selectMachine = (e) => {
    const btnSubmitMachines = document.getElementById('submit-machine')
    btnSubmitMachines.disabled = false
    setMachineId(e.currentTarget.value)
  }

// Workers Logic
  const fetchWorkers = () => {
    fetch(`${url}/api/v1/workers/conductors`, {
      method: 'GET',
      'Content-Type': 'application/json'
    }).then(response => response.json()).then(data => setListWorkers(data))
  }

  // C'est en cliquant sur ce bouton (form des workers) qu'on valide la création d'une instance dans la table conducteurs
  // On active donc le trigger ici pour relancer l'App
  const handleSubmitWorkers = (e) => {
    e.preventDefault()
    workersId.forEach(workerId => {
      axios({
        url: `${url}/api/v1/conductors/${machineId}/${workerId}?ppsp_id=${ppspsId}`,
        method: 'POST',
        data: {
          conductor: {
            machine_id: machineId,
            ppsp_id: ppspsId,
            worker_id: workerId,
          }
        }
      }).then(response => {
        setShowListWorkers(false)
        setShowListCategory(true)
        // Clean the inputs of the form
        formWorkers.reset()
        let count = trigger
        count += 1
        setTrigger(count)
      })
      .then(response => {
        // Reset all the infos
        clearState()
      })
      .catch(error => console.log(error))
    })
  }

  const selectWorkers = (e) => {
    const value = e.currentTarget.value
    if(!workersId.includes(value)) {
      setWorkersId([...workersId, value])
    }
  }

// Conductors logic
  const fetchConductors = () => {
    fetch(`${url}/api/v1/conductors?ppsps_id=${ppspsId}`, {
      method: 'GET',
      'Content-Type': 'application/json'
    }).then(response => response.json()).then(listConductors => {
      // On groupes les couples machines/workers par "category - caces" pour avoir un hash organisé par couple "category - caces"
      const grouped = listConductors.reduce((acc, obj) => {
        const key = `${obj.machine_category} - ${obj.machine_caces}` 
        if(!acc[key]){
          acc[key] = [];
        }
        acc[key].push(obj);
        return acc;
      }, {});


      // React doesn't accept Object as a child so whe have to pass them in array
      const groupedArray = []
      for (let key in grouped) {
        if (grouped.hasOwnProperty(key)) {
           const obj = (key, grouped[key]);
           groupedArray.push(obj)
        }
      }
      setListSelected(groupedArray)
      // On reset la selection des Workers
      setWorkersId([])
    })
  }

  const handleDelete = async (id) => {
    await fetch(`${url}/api/v1/conductors/${id}`, {
      method: 'DELETE'
    }).then(response => {
      let count = trigger
      setTrigger(count + 1)
    })
  }
  
  // Start the App
  useEffect(() => {
    const fetchData = async () => {
      await fetchCategories(),
      fetchConductors()
    }
    fetchData()
  }, [trigger])

  return (
    <React.Fragment>
      <div className="form-react-conductors">
        <ListCategory listCategory={listCategory} handleSubmitCategory={handleSubmitCategory} selectCategory={selectCategory} showListCategory={showListCategory}/>
        <ListMachines listMachines={listMachines} handleSubmitMachine={handleSubmitMachine} selectMachine={selectMachine} selectedMachineId={machineId} handleReset={handleReset} showListMachines={showListMachines}/>
        <WorkersList listWorkers={listWorkers} handleSubmitWorkers={handleSubmitWorkers} selectWorkers={selectWorkers} showListWorkers={showListWorkers}/>
      </div>
      <SavedVehicules listSelected={listSelected} handleDelete={handleDelete}/>
    </React.Fragment>
  )
}

export default App
