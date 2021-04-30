import React from 'react';
import {AltitudeWork} from './App'

interface PropsSavedItems {
  altitude_work: AltitudeWork;
  handleRemove: Function;
}

const SavedItems = ({ altitude_work, handleRemove } : PropsSavedItems) : JSX.Element => (
  <div className="card-form-selected">
    <div
      className="card-form-delete"
      onClick={() => handleRemove(altitude_work)}
    >
      x
    </div>
    <div className="line">
      <i className="fas fa-hard-hat mr-2" />
      {altitude_work.name}
    </div>
  </div>
);

export default SavedItems;
