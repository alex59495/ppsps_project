import React from 'react'

const InputWorker = ({worker}) => {
  return (
    <div className="form-check">
      <input className="form-check-input" type="checkbox" value={worker.id} id={`check_worker_${worker.id}`} />
      <label className="form-check-label" htmlFor={`check_worker_${worker.id}`}>
        {`${worker.first_name} ${worker.last_name}`}
      </label>
    </div>
  )
}

export default InputWorker
