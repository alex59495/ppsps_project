import React from 'react'
import InputMachine from './InputMachine'

const MachinesList = ({listMachines, handleMachine, selectMachine}) => {
  const renderList = listMachines.map(machine => {
    return(
        <InputMachine key={machine.id} machine={machine}/>
    )
  })
  

  return (
    <form className='container-center-column form-list-machines' onSubmit={handleMachine}>
      <div className="form-select-machines-title">
        Choisir un véhicule dans la liste ci-dessous si votre chantier implique la conduite d'engins
      </div>
      <select className="form-select-machines" onClick={selectMachine}>
        {renderList}
      </select>
      <div className='d-flex justify-content-center mt-4'>
        <button type='submit' className='btn-orange' id='submit-machine' disabled>OK</button>
      </div>
    </form>
  )
}

export default MachinesList
