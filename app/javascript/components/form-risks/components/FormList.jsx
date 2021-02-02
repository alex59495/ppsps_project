import React from 'react';
import FormInput from './FormInput';

const FormList = ({ risks, handleClick }) => (
  <div className="form-risks-list form-flex-element">
    <p>Les types de travaux disponibles</p>
    <fieldset className="form-group check_boxes optional ppsp_risks">
      <legend className="col-form-label pt-0" />
      <input type="hidden" name="ppsp[risks][]" value="" />
      <FormInput risks={risks} handleClick={handleClick} formList />
    </fieldset>
  </div>
);

export default FormList;
