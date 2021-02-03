import React from 'react';
import FormInput from './FormInput';

const ListSelected = ({ lifesavers, handleClick }) => {
  const renderList = lifesavers.map(lifesaver => {
    return(
      <FormInput 
        key={lifesaver.id}
        id={lifesaver.id} 
        handleClick={handleClick} 
        name={`${lifesaver.first_name} ${lifesaver.last_name}`}
      />
    )
  })

  return(
    <div className="form-selected-lifesaver form-flex-element">
      <p>Mes ajouts</p>
      <div className="selected-lifesavers">
        {renderList}
      </div>
    </div>
  )
};

export default ListSelected;
