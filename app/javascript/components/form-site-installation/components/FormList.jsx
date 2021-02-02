import React from 'react';
import FormInput from './FormInput';

const FormList = ({ site_installations, handleClick }) => (
  <div className="form-site_installations-list form-flex-element">
    <p>Les types de travaux disponibles</p>
    <fieldset className="form-group check_boxes optional ppsp_site_installations">
      <legend className="col-form-label pt-0" />
      <input type="hidden" name="ppsp[site_installations][]" value="" />
      <FormInput
        site_installations={site_installations}
        handleClick={handleClick}
        formList
      />
    </fieldset>
  </div>
);

export default FormList;
