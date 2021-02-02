import React from 'react'
import InputWorker from './InputWorker'

const WorkersList = ({listWorkers, handleWorkers, selectWorkers}) => {
  // Order the list by name
  const listOrdered = listWorkers.sort((a, b) => {
    const nameA = `${a.first_name} ${a.last_name}`.toLowerCase();
    const nameB = `${b.first_name} ${b.last_name}`.toLowerCase();

    let comparison = 0;
      if (nameA > nameB) {
        comparison = 1;
      } else if (nameA < nameB) {
        comparison = -1;
      }
      return comparison;
  })

  const renderList = listOrdered.map(worker => {
    return(
      <InputWorker key={worker.id} worker={worker} selectWorkers={selectWorkers}/>
    )
  })
  
  return (
    <form className='container-center-column chechboxes-workers' style={{display: 'none'}} onSubmit={handleWorkers}>
      <div className="form-checkboxes-title">
        Choisir les conducteurs de ce véhicule
      </div>
      <div className="form-checkboxes-subtitle text-alert">
        Seuls les compagnons renseignés comme « conducteurs » sont listés
      </div>
      <div className="form-checkboxes">
        {renderList}
      </div>
      <button type='submit' className='btn-orange'>OK</button>
    </form>
  )
}

export default WorkersList
