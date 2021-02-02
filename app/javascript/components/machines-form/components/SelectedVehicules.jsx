import React from 'react'
import SelectedWorkers from './SelectedWorkers'

const SelectedVehicules = ({listSelected, handleDelete}) => {
  const renderList = listSelected.map(vehicule => {
    const id = vehicule[0].id
    const nameVehicule = vehicule[0].machine_name
    return (
        <div className="card-vehicule" key={id}>
          <div className="card-vehicule-title">
            {nameVehicule}
          </div>
          <div className="card-vehicule-body">
            <SelectedWorkers vehicule={vehicule} handleDelete={handleDelete}/>
          </div>
        </div>
    )
  })

  if(listSelected.length > 0) {
    return (
      <div className="container-flex form-conductors-selection">
        {renderList}
      </div>
    )
  } else {
    return null
  }
}

export default SelectedVehicules
