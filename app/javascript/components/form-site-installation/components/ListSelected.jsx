import React from 'react';
import FormInput from './FormInput';

const ListSelected = ({ site_installations, handleClick }) => (
  <div className="form-selected-site_installation form-flex-element">
    <p>Mes ajouts</p>
    <div className="selected-site_installations">
      <FormInput
        site_installations={site_installations}
        handleClick={handleClick}
        formList={false}
      />
    </div>
  </div>
);

export default ListSelected;
