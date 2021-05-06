import React from 'react';
import {Conductor} from './App';

interface PropsSavedWorkers {
  vehicule: Conductor[];
  handleDelete: (id: number) => void;
}

const ItemSelect = ({vehicule, handleDelete} : PropsSavedWorkers) : JSX.Element => {
  const renderItem = vehicule.map(worker => {
    const conductorId = worker.id
    return(
      <div className="worker d-flex" key={worker.id}>
        <div className="worker-name">
          {`${worker.worker_first_name} ${worker.worker_last_name}`}
        </div>
        <div className="card-delete ml-2" onClick={() => handleDelete(conductorId)}>
          x
        </div>
      </div>
    )
  })

  return (
    <>
      {renderItem}
    </>
  )
}

export default ItemSelect
