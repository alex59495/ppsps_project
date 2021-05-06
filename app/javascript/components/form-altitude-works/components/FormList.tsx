import React from 'react';
import { AltitudeWork } from './App';
import FormInput from './FormInput';
import {PropsAltitudeList} from './ListSelected';

const FormList = ({ altitude_works, handleClick } : PropsAltitudeList) : JSX.Element => {
  // Order the list by name
  const listOrdered : AltitudeWork[] = altitude_works.sort((a : AltitudeWork, b : AltitudeWork) => {
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

  const renderList : JSX.Element[] = listOrdered.map(altitude_work => {
    return(
      <FormInput
        id={altitude_work.id}
        handleClick={handleClick}
        name={altitude_work.name}
        check = {true}
        key={altitude_work.id}
      />
    )
  })

  return(
    <div className="form-altitude_works-list form-flex-element">
      <div className="title">
        <p>Accès au chantier disponibles</p>
      </div>
      <fieldset className="form-group check_boxes optional ppsp_altitude_works">
        <legend className="col-form-label pt-0" />
        <input type="hidden" name="ppsp[altitude_works][]" value="" />
        {renderList}
      </fieldset>
    </div>
  )
};

export default FormList;
