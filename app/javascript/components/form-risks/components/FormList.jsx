import React from 'react';
import FormInput from './FormInput';

const FormList = ({ risks, handleClick }) => {
  // Order the list by name
  const listOrdered = risks.sort((a, b) => {
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
  
  const renderList = listOrdered.map(risk => {
    return(
      <FormInput 
        id={risk.id} 
        name={risk.name} 
        formList = {true}
        handleClick={handleClick}
        key={risk.id}
      />
    )
  })

  return (
    <div className="form-risks-list form-flex-element">
      <div className="title">
        <p>Les types de travaux disponibles</p>
      </div>
      <fieldset className="form-group check_boxes optional ppsp_risks">
        <legend className="col-form-label pt-0" />
        <input type="hidden" name="ppsp[risks][]" value="" />
        {renderList}
      </fieldset>
    </div>
  )
}

export default FormList;
