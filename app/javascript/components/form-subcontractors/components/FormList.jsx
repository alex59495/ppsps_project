import React from 'react';
import FormInput from './FormInput';

const FormList = ({ subcontractors, handleClick }) => (
  <div className="form-subcontractors-list form-flex-element">
    <p>Les sous-traitans disponibles</p>
    <fieldset className="form-group check_boxes optional ppsp_subcontractors">
      <legend className="col-form-label pt-0" />
      <input type="hidden" name="ppsp[subcontractors][]" value="" />
      <FormInput
        subcontractors={subcontractors}
        handleClick={handleClick}
        formList
      />
    </fieldset>
  </div>
);

export default FormList;
