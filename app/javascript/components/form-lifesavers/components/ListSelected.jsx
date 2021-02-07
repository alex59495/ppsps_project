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
      <div className="title">
        <p>Mes ajouts</p>
      </div>
      <div className="selected-lifesavers selected-form-check">
        {renderList}
      </div>
    </div>
  )
};

export default ListSelected;
