import React from 'react';
import FormInput from './FormInput';

const ListSelected = ({ subcontractors, handleClick }) => {
  const renderList = subcontractors.map(subcontractor => {
    <FormInput
        id={subcontractor.id}
        name={subcontractor.name}
        responsible_name={subcontractor.responsible_name}
        work={subcontractor.work}
        handleClick={handleClick}
        key={subcontractor.id}
      />
  })

  return(
    <div className="form-selected-subcontractor form-flex-element">
      <p>Mes ajouts</p>
      <div className="selected-subcontractors">
        {renderList}
      </div>
    </div>
  )
}

export default ListSelected;
