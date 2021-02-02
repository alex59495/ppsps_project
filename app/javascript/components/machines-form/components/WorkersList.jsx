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
      {renderList}
      <button type='submit'>OK</button>
    </form>
  )
}

export default WorkersList
