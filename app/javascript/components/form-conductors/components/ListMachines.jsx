import React from 'react'
import InputMachine from './InputMachine'

const ListMachines = ({listMachines, handleMachine, selectMachine}) => {
  const renderList = listMachines.map(machine => {
   return(
   <InputMachine 
      key={machine.id} 
      caces={machine.caces} 
      id={machine.id} 
      description={machine.description}
    />)
  });

  return (
    <form className='container-center-column form-list-machines' onSubmit={handleMachine} style={{display: 'none'}} >
      <div className="form-select-machines-title">
        Choisir une catégorie de CACES
      </div>
      <select className="form-select-machines" name="formSelectMachine" id="formSelectMachine"  onClick={selectMachine}>
        {renderList}
      </select>
      <div className='d-flex justify-content-center mt-4'>
        <button type='submit' className='btn-orange' id='submit-machine'>OK</button>
      </div>
    </form>
  )
}

export default ListMachines
