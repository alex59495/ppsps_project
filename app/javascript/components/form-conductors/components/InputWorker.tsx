import React from 'react';
import {Worker} from './App'

interface InputWorker {
  worker: Worker,
  selectWorkers: () => void
}

const InputWorker = ({worker, selectWorkers} : InputWorker) : JSX.Element => {
  return (
    <div className="form-check">
      <input className="form-check-input" type="checkbox" value={worker.id} id={`check_worker_${worker.id}`} onClick={selectWorkers} />
      <label className="form-check-label" htmlFor={`check_worker_${worker.id}`}>
        {`${worker.first_name} ${worker.last_name}`}
      </label>
    </div>
  )
}

export default InputWorker
