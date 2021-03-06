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
          mobile={site_installation.mobile ? 'mobile' : 'fixe'}
          formList = {false}
        />
    )
  })

  return(
    <div className="form-selected-site_installation form-flex-element">
      <div className="title">
        <p>Mes ajouts</p>
      </div>
      <div className="selected-site_installations selected-form-check">
        {renderList}
      </div>
    </div>
  )
}

export default ListSelected;
