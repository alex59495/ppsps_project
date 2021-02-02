import React from 'react'
import SelectedWorkers from './SelectedWorkers'

const SelectedVehicules = ({listSelected}) => {
  const renderList = listSelected.map(vehicule => {
    const id = vehicule[0].id
    const nameVehicule = vehicule[0].machine_name
    return (
        <React.Fragment key={id}>
          <div className="card-vehicule-title">
            {nameVehicule}
          </div>
          <div className="card-vehicule-body">
            <SelectedWorkers vehicule={vehicule} />
          </div>
        </React.Fragment>
    )
  })

  return (
    <div className="seleted-items">
      {renderList}
    </div>
  )
}

export default SelectedVehicules
