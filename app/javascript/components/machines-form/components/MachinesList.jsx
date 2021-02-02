import React from 'react'
import InputMachine from './InputMachine'

const MachinesList = ({listMachines, handleMachine, selectMachine}) => {
  const renderList = listMachines.map(machine => {
    return(
        <InputMachine key={machine.id} machine={machine}/>
    )
  })
  

  return (
    <form className='form-list-machines' onSubmit={handleMachine}>
      <select className="form-select-machines" onClick={selectMachine}>
        {renderList}
      </select>
      <button type='submit' id='submit-machine' disabled>OK</button>
    </form>
  )
}

export default MachinesList
