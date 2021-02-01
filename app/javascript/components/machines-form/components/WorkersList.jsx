import React from 'react'
import InputWorker from './InputWorker'

const WorkersList = ({listWorkers}) => {
  const renderList = listWorkers.map(worker => {
    return(
      <InputWorker key={worker.id} worker={worker}/>
    )
  })
  return (
    <div className='chechboxes_workers'>
      {renderList}
    </div>
  )
}

export default WorkersList
