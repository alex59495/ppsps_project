import React from 'react'
import InputWorker from './InputWorker'

const WorkersList = ({listWorkers, handleWorkers, selectWorkers}) => {
  const renderList = listWorkers.map(worker => {
    return(
      <InputWorker key={worker.id} worker={worker} selectWorkers={selectWorkers}/>
    )
  })
  
  return (
    <form className='chechboxes-workers' style={{display: 'none'}} onSubmit={handleWorkers}>
      <div className="form-checkboxes-title">
        Choisir un ou plusieurs compagnons
      </div>
      <div className="form-checkboxes">
        {renderList}
      </div>
      <div className='d-flex justify-content-center'>
        <button type='submit' class='btn-orange'>OK</button>
      </div>
    </form>
  )
}

export default WorkersList
