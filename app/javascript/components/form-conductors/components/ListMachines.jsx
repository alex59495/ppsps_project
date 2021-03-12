import React from 'react'
import InputMachine from './InputMachine'
import MachineDescription from './MachineDescription';

const ListMachines = ({listMachines, handleSubmitMachine, selectMachine, selectedMachineId}) => {

  const renderDescription = listMachines.map(machine => {
    if(machine.id == selectedMachineId) {
      return(
        <MachineDescription 
          key={machine.id} 
          description={machine.description}
          image={machine.image} 
        />
      )
    }
  })

  const renderList = listMachines.map(machine => {
   return(
    <InputMachine 
        key={machine.id} 
        caces={machine.caces} 
        id={machine.id} 
      />
    )
  });

  const renderSelectList = () => {
    if(listMachines.length === 0) {
      return(
        <b>
          Plus d'option selectionnable
        </b>
      )
    } else {
      return(
        <select className="form-select-machines" name="formSelectMachine" id="formSelectMachine"  onClick={selectMachine}>
          {renderList}
        </select>
      )
    }
  }

  return (
    <form className='container-center-column form-list-machines' onSubmit={handleSubmitMachine} style={{display: 'none'}} >
      <div className="form-select-machines-title">
        Choisir une catégorie de CACES
      </div>
      {renderSelectList()}
      <div className='d-flex justify-content-center mt-4'>
        <button type='submit' className='btn-orange' id='submit-machine' disabled>OK</button>
      </div>
      {renderDescription}
    </form>
  )
}

export default ListMachines
