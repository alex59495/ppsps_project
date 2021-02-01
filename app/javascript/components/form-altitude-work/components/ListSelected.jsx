import React from 'react';
import FormInput from './FormInput';

const ListSelected = ({ altitude_works, handleClick }) => (
  <div className="form-selected-altitude_work form-flex-element">
    <p>Mes ajouts</p>
    <div className="selected-altitude_works">
      <FormInput
        altitude_works={altitude_works}
        handleClick={handleClick}
        formList={false}
      />
    </div>
  </div>
);

export default ListSelected;
