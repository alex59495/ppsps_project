import React from 'react';
import InputWorker from './InputWorker';
import {Worker} from './App';

interface PropsWorkerList {
  listWorkers: Worker[],
  handleSubmitWorkers: (e: React.FormEvent) => void,
  selectWorkers: (e : React.MouseEvent) => void,
  showListWorkers: boolean,
}

const WorkersList = ({listWorkers, handleSubmitWorkers, selectWorkers, showListWorkers} : PropsWorkerList) : JSX.Element => {
  // Order the list by name
  const listOrdered : Worker[] = listWorkers.sort((a : Worker, b : Worker) => {
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

  const renderList : JSX.Element[] = listOrdered.map((worker : Worker) => {
    return(
      <InputWorker key={worker.id} worker={worker} selectWorkers={selectWorkers}/>
    )
  })
  
  if(showListWorkers) {
    return (
      <form className='container-center-column checkboxes-workers' onSubmit={(e) => handleSubmitWorkers(e)}>
        <div className="form-checkboxes-title">
          Choisir les conducteurs de ce véhicule
        </div>
        <div className="form-checkboxes-subtitle text-alert">
          Seuls les compagnons renseignés comme « conducteurs » sont listés
        </div>
        <div className="form-checkboxes">
          {renderList}
        </div>
        <button type='submit' className='btn-orange' id='submit-conductors' disabled>OK</button>
      </form>
    )
  } else {
    return null
  }
}

export default WorkersList
