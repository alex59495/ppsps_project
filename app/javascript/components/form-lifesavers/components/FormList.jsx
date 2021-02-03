import React from 'react';
import FormInput from './FormInput';

const FormList = ({ lifesavers, handleClick }) => {
  const renderList = lifesavers.map(lifesaver => {
    return(
      <FormInput 
        key={lifesaver.id}
        id={lifesaver.id} 
        handleClick={handleClick} 
        formList 
        name={`${lifesaver.first_name} ${lifesaver.last_name}`}
      />
    )
  })

  return(
    <div className="form-lifesavers-list form-flex-element">
      <p>Liste des sauveteurs de l'entreprise</p>
      <fieldset className="form-group check_boxes optional ppsp_lifesavers">
        <legend className="col-form-label pt-0" />
        <input type="hidden" name="ppsp[lifesavers][]" value="" />
        {renderList}
      </fieldset>
  </div>
  )
};

export default FormList;
