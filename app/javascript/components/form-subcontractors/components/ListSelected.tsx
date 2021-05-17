import React from 'react';
import FormInput from './FormInput';

import {Subcontractor} from './App';

interface PropsListSelected {
  subcontractors: Subcontractor[];
  handleClick: (e : React.MouseEvent) => void
}

const ListSelected = ({ subcontractors, handleClick } : PropsListSelected) : JSX.Element => {
  const renderList : JSX.Element[] = subcontractors.map((subcontractor : Subcontractor) => {
    return(
      <FormInput
          id={subcontractor.id}
          name={subcontractor.name}
          responsible_name={subcontractor.responsible_name}
          work={subcontractor.work}
          handleClick={handleClick}
          key={subcontractor.id}
          checked = {false}
        />
    )
  })

  return(
    <div className="form-selected-subcontractor form-flex-element">
      <div className="title">
        <p>Mes ajouts</p>
      </div>
      <div className="selected-subcontractors selected-form-check">
        {renderList}
      </div>
    </div>
  )
}

export default ListSelected;
