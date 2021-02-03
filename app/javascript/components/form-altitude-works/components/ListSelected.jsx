import React from 'react';
import FormInput from './FormInput';

const ListSelected = ({ altitude_works, handleClick }) => {
  const renderList = altitude_works.map(altitude_work => {
    return(
      <FormInput 
        id={altitude_work.id} 
        handleClick={handleClick} 
        name={altitude_work.name} 
        key={altitude_work.id}
      />
    )
  })

  return(
    <div className="form-selected-altitude_work form-flex-element">
      <p>Mes ajouts</p>
      <div className="selected-altitude_works">
        {renderList}
      </div>
    </div>
  )
};

export default ListSelected;
