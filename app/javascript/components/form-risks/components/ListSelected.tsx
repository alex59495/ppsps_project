import React from 'react';
import FormInput from './FormInput';

import {Risk} from './App';

interface PropsListSelected {
  risks: Risk[];
  handleClick: (e: React.MouseEvent) => void;
}

const ListSelected = ({ risks, handleClick } : PropsListSelected) => {
  const renderList = risks.map((risk : Risk) => {
    return (<FormInput 
      name={risk.name} 
      handleClick={handleClick} 
      id={risk.id} 
      key={risk.id} 
      checked={false}
    />
    )
  })

  return(
    <div className="form-selected-risk form-flex-element">
      <div className="title">
        <p>Mes ajouts</p>
      </div>
      <div className="selected-risks selected-form-check">
        {renderList}
      </div>
    </div>
  )
}

export default ListSelected;
