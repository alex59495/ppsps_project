import React from 'react';
import FormInput from './FormInput';

const ListSelected = ({ risks, handleClick }) => (
  <div className="form-selected-risk form-flex-element">
    <p>Mes ajouts</p>
    <div className="selected-risks">
      <FormInput risks={risks} handleClick={handleClick} formList={false} />
    </div>
  </div>
);

export default ListSelected;
