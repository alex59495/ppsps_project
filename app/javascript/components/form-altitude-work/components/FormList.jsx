import React from 'react';
import FormInput from './FormInput';

const FormList = ({ altitude_works, handleClick }) => (
  <div className="form-altitude_works-list form-flex-element">
    <p>Les types de travaux disponibles</p>
    <fieldset className="form-group check_boxes optional ppsp_altitude_works">
      <legend className="col-form-label pt-0" />
      <input type="hidden" name="ppsp[altitude_works][]" value="" />
      <FormInput
        altitude_works={altitude_works}
        handleClick={handleClick}
        formList
      />
    </fieldset>
  </div>
);

export default FormList;
