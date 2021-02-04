import React from 'react';
import FormInput from './FormInput';

const FormList = ({ altitude_works, handleClick }) => {
  // Order the list by name
  const listOrdered = altitude_works.sort((a, b) => {
    const nameA = a.name.toLowerCase();
    const nameB = b.name.toLowerCase();

    let comparison = 0;
      if (nameA > nameB) {
        comparison = 1;
      } else if (nameA < nameB) {
        comparison = -1;
      }
      return comparison;
  })

  const renderList = listOrdered.map(altitude_work => {
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
