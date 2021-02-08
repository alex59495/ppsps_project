import React, {useState, useEffect} from 'react'
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

// List des éléments déjà selectionés par l'utilisateur
  const [listSelected, setListSelected] = useState([])

// Add a trigger to reactivate the app when creating a new conductor
  const [trigger, setTrigger] = useState(0)

  const url = window.location.protocol

  const ppspsId = document.getElementById('conductors-form-react').dataset
  .ppsps_id;

// DOM
  const btnSubmitMachines = document.getElementById('submit-machine')
  const btnSubmitCategories = document.getElementById('submit-category')
  const formListCategory = document.querySelector('.form-list-categories')
  const formListMachines = document.querySelector('.form-list-machines')
  const formWorkers = document.querySelector('.checkboxes-workers')

// // Machine's Logic
//   const fetchMachines = () => {
//     fetch(`${url}/api/v1/machines?ppsps_id=${ppspsId}`, {
//       method: 'GET',
//       'Content-Type': 'application/json'
//     }).then(response => response.json()).then(data => setlistCategory(data))
//   }

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


  const handleCategory = async (e) => {
    e.preventDefault()
    await fetchMachines()
    formListCategory.style.display = 'none';
    formListMachines.style.display = 'flex';
    // Clean the inputs of the form
    formListCategory.reset()
    btnSubmitCategories.disabled = true

  }

  const selectCategory = (e) => {
    setCategory(e.currentTarget.value)
    btnSubmitCategories.disabled = false
  }



// Machines' logic
  const handleMachine = async (e) => {
    e.preventDefault()
    await fetchWorkers()
    formListMachines.style.display = 'none';
    formWorkers.style.display = 'flex';
    // Clean the inputs of the form
    formListMachines.reset()
    btnSubmitMachines.disabled = true
  }

  const selectMachine = (e) => {
    setMachineId(e.currentTarget.value)
    btnSubmitMachines.disabled = false
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
  const handleWorkers = (e) => {
    e.preventDefault()
    workersId.forEach(workerId => {
      fetch(`${url}/api/v1/conductors/${machineId}/${workerId}?ppsp_id=${ppspsId}`, {
        method: 'POST'
      }).then(response => {
        formWorkers.style.display = 'none';
        formListCategory.style.display = 'flex';
        // Clean the inputs of the form
        formWorkers.reset()
        let count = trigger
        count += 1
        setTrigger(count)
      })
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
        <ListCategory listCategory={listCategory} handleCategory={handleCategory} selectCategory={selectCategory}/>
        <ListMachines listMachines={listMachines} handleMachine={handleMachine} selectMachine={selectMachine}/>
        <WorkersList listWorkers={listWorkers} handleWorkers={handleWorkers} selectWorkers={selectWorkers}/>
      </div>
      <SavedVehicules listSelected={listSelected} handleDelete={handleDelete}/>
    </React.Fragment>
  )
}

export default App
