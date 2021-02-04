import React from 'react';
import FormInput from './FormInput';

const FormList = ({ site_installations, handleClick }) => {
  // Order the list by name
  const listOrdered = site_installations.sort((a, b) => {
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

  const renderList = listOrdered.map(site_installation => {
    return(
      <FormInput
      id={site_installation.id}
      name={site_installation.name}
      handleClick={handleClick}
      formList
      key={site_installation.id}
    />
    )
  })

  return(
    <div className="form-site_installations-list form-flex-element">
      <p>Installations disponibles</p>
      <fieldset className="form-group check_boxes optional ppsp_site_installations">
        <legend className="col-form-label pt-0" />
        <input type="hidden" name="ppsp[site_installations][]" value="" />
        {renderList}
      </fieldset>
    </div>
  )
}

export default FormList;
