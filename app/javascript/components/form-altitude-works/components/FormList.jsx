import React from 'react';
import FormInput from './FormInput';

const FormList = ({ altitude_works, handleClick }) => {
  const renderList = altitude_works.map(altitude_work => {
    return(
      <FormInput
        id={altitude_work.id}
        handleClick={handleClick}
        name={altitude_work.name}
        formList
        key={altitude_work.id}
      />
    )
  })

  return(
    <div className="form-altitude_works-list form-flex-element">
      <p>Accès au chantier disponibles</p>
      <fieldset className="form-group check_boxes optional ppsp_altitude_works">
        <legend className="col-form-label pt-0" />
        <input type="hidden" name="ppsp[altitude_works][]" value="" />
        {renderList}
      </fieldset>
    </div>
  )
};

export default FormList;
