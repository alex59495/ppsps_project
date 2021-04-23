import React from 'react'
import InputWorker from './InputWorker'

const WorkersList = ({listWorkers, handleSubmitWorkers, selectWorkers, showWorkerList}) => {
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
  
  if(showWorkerList) {
    return (
      <form className='container-center-column checkboxes-workers' onSubmit={handleSubmitWorkers}>
        <div className="form-checkboxes-title">
          Choisir les conducteurs de ce véhicule
        </div>
        <div className="form-checkboxes-subtitle text-alert">
          Seuls les compagnons renseignés comme « conducteurs » sont listés
        </div>
        <div className="form-checkboxes">
          {renderList}
        </div>
        <button type='submit' className='btn-orange' id='submit-conductors'>OK</button>
      </form>
    )
  } else {
    return null
  }
}

export default WorkersList
