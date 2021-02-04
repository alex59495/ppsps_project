import { render } from 'enzyme';
import React from 'react';
import FormInput from './FormInput';

const FormList = ({ subcontractors, handleClick }) => {
  // Order the list by name
  const listOrdered = subcontractors.sort((a, b) => {
    const nameA = `${a.name} - ${a.responsible_name} - ${a.work}`.toLowerCase();
    const nameB = `${b.name} - ${b.responsible_name} - ${b.work}`.toLowerCase();

    let comparison = 0;
      if (nameA > nameB) {
        comparison = 1;
      } else if (nameA < nameB) {
        comparison = -1;
      }
      return comparison;
  })

  const renderList = listOrdered.map(subcontractor => {
    return(
      <FormInput
      id={subcontractor.id}
      name={subcontractor.name}
      responsible_name={subcontractor.responsible_name}
      work={subcontractor.work}
      handleClick={handleClick}
      key={subcontractor.id}
      formList
    />
    )
  })

  return(
    <div className="form-subcontractors-list form-flex-element">
      <p>Les sous-traitants disponibles</p>
      <fieldset className="form-group check_boxes optional ppsp_subcontractors">
        <legend className="col-form-label pt-0" />
        <input type="hidden" name="ppsp[subcontractors][]" value="" />
        {renderList}
      </fieldset>
    </div>
  )
}

export default FormList;
