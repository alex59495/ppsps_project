import React from 'react'
import SavedWorkers from './SavedWorkers';
import {Conductor} from './App'

interface PropsSavedVehicules {
  listSelected: Conductor[][];
  handleDelete: () => void
}

const SavedVehicules = ({listSelected, handleDelete} : PropsSavedVehicules) : JSX.Element => {
  console.log(listSelected)
  const renderList : JSX.Element[] = listSelected.map((vehicule : Conductor[]) => {
    const id = vehicule[0].id
    const categoryVehicle = vehicule[0].machine_category
    const cacesVehicle = vehicule[0].machine_caces
    return (
        <div className="card-vehicule" key={id}>
          <div className="card-vehicule-title">
            {categoryVehicle}
          </div>
          <div className="card-vehicule-subtitle">
            {cacesVehicle}
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
