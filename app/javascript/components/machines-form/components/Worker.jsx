import React from 'react'

const Worker = ({worker}) => {
  return (
    <div>
      {`${worker.worker_first_name} ${worker.worker_last_name}`}
    </div>
  )
}

export default Worker
