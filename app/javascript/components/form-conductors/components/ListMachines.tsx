import React from 'react'
import InputMachine from './InputMachine'
import MachineDescription from './MachineDescription';
import {Machine} from './App';


interface PropsListMachine {
  listMachines: Machine[];
  handleSubmitMachine: (e : React.FormEvent) => void;
  selectMachine: (e : React.MouseEvent) => void;
  selectedMachineId: number;
  handleReset: () => void;
  showListMachines: boolean;
}

const ListMachines = ({listMachines, handleSubmitMachine, selectMachine, selectedMachineId, handleReset, showListMachines} : PropsListMachine) : JSX.Element => {

  const renderDescription : JSX.Element[] = listMachines.map((machine : Machine) => {
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

  const renderList : JSX.Element[] = listMachines.map((machine : Machine) => {
   return(
    <InputMachine 
        key={machine.id} 
        caces={machine.caces} 
        id={machine.id} 
      />
    )
  });

  const renderSelectList = () : JSX.Element => {
    if(!listMachines.length) {
      return(
        <>
          <b>
            Plus d'option selectionnable pour ce type d'engin
          </b>
          <button className='btn-orange mt-3' onClick={handleReset}>Voir d'autres options</button>
        </>
      )
    } else {
      return(
        <>
          <select className="form-select-machines" name="formSelectMachine" id="formSelectMachine"  onClick={selectMachine}>
            {renderList}
          </select>
          <div className='d-flex justify-content-center mt-4'>
            <button type='submit' className='btn-orange' id='submit-machine' disabled>OK</button>
          </div>
        </>
      )
    }
  }

  if(showListMachines) {
    return (
      <>
        <form className='container-center-column form-list-machines' onSubmit={(e) => handleSubmitMachine(e)} >
          <div className="form-select-machines-title">
            Choisir une catégorie de CACES
          </div>
          {renderSelectList()}
          {renderDescription}
        </form>
      </>
    )
  } else {
    return null
  }
}

export default ListMachines
