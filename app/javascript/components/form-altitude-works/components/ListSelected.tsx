import React from 'react';
import FormInput from './FormInput';
import {AltitudeWork} from './App'

export interface PropsAltitudeList {
  altitude_works: AltitudeWork[];
  handleClick: Function
}

const ListSelected = ({ altitude_works, handleClick } : PropsAltitudeList) : JSX.Element => {
  const renderList = altitude_works.map(altitude_work => {
    return(
      <FormInput 
        id={altitude_work.id} 
        handleClick={handleClick} 
        name={altitude_work.name} 
        key={altitude_work.id}
        formList = {false}
      />
    )
  })

  return(
    <div className="form-selected-altitude_work form-flex-element">
      <div className="title">
        <p>Mes ajouts</p>
      </div>
      <div className="selected-altitude_works selected-form-check">
        {renderList}
      </div>
    </div>
  )
};

export default ListSelected;
