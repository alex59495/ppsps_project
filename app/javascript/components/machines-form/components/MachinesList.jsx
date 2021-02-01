import React from 'react'
import InputMachine from './InputMachine'

const MachinesList = ({listMachines}) => {
  const renderList = listMachines.map(machine => {
    return(
        <InputMachine key={machine.id} machine={machine}/>
    )
  })

  return (
    <div className='form-list-machines'>
      <select className="form-select-machines">
        {renderList}
      </select>
    </div>
  )
}

export default MachinesList
