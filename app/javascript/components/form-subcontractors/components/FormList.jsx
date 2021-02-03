import { render } from 'enzyme';
import React from 'react';
import FormInput from './FormInput';

const FormList = ({ subcontractors, handleClick }) => {
  const renderList = subcontractors.map(subcontractor => {
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
      <p>Les sous-traitans disponibles</p>
      <fieldset className="form-group check_boxes optional ppsp_subcontractors">
        <legend className="col-form-label pt-0" />
        <input type="hidden" name="ppsp[subcontractors][]" value="" />
        {renderList}
      </fieldset>
    </div>
  )
}

export default FormList;
