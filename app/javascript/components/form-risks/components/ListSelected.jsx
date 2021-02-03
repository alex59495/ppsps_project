import React from 'react';
import FormInput from './FormInput';

const ListSelected = ({ risks, handleClick }) => {
  const renderList = risks.map(risk => {
    return (<FormInput 
      name={risk.name} 
      handleClick={handleClick} 
      id={risk.id} 
      key={risk.id} />
    )
  })

  return(
    <div className="form-selected-risk form-flex-element">
      <p>Mes ajouts</p>
      <div className="selected-risks">
        {renderList}
      </div>
    </div>
  )
}

export default ListSelected;
