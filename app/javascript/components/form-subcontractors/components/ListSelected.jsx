import React from 'react';
import FormInput from './FormInput';

const ListSelected = ({ subcontractors, handleClick }) => {
  const renderList = subcontractors.map(subcontractor => {
    return(
      <FormInput
          id={subcontractor.id}
          name={subcontractor.name}
          responsible_name={subcontractor.responsible_name}
          work={subcontractor.work}
          handleClick={handleClick}
          key={subcontractor.id}
          formList = {false}
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
