import React from 'react'
import SavedWorkers from './SavedWorkers'

const SavedVehicules = ({listSelected, handleDelete}) => {
  const renderList = listSelected.map(vehicule => {
    const id = vehicule[0].id
    const nameVehicule = vehicule[0].machine_name
    return (
        <div className="card-vehicule" key={id}>
          <div className="card-vehicule-title">
            {nameVehicule}
          </div>
          <div className="card-vehicule-body">
            <SavedWorkers vehicule={vehicule} handleDelete={handleDelete}/>
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

export default SavedVehicules
