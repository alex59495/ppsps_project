import React from 'react';
import FormInput from './FormInput';

const ListSelected = ({ site_installations, handleClick }) => {
  const renderList = site_installations.map(site_installation => {
    return(
      <FormInput
          id={site_installation.id}
          name={site_installation.name}
          handleClick={handleClick}
          key={site_installation.id}
        />
    )
  })

  return(
    <div className="form-selected-site_installation form-flex-element">
      <p>Mes ajouts</p>
      <div className="selected-site_installations">
        {renderList}
      </div>
    </div>
  )
}

export default ListSelected;
