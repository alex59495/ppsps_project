import React from 'react';
import FormInput from './FormInput';

const ListSelected = ({ subcontractors, handleClick }) => (
  <div className="form-selected-subcontractor form-flex-element">
    <p>Mes ajouts</p>
    <div className="selected-subcontractors">
      <FormInput
        subcontractors={subcontractors}
        handleClick={handleClick}
        formList={false}
      />
    </div>
  </div>
);

export default ListSelected;
