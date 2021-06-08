import React from 'react';

import {Risk} from './App';

interface PropsSavedItem {
  risk: Risk;
  handleRemove: (e: React.MouseEvent) => void;
}

const SavedItems = ({ risk, handleRemove } : PropsSavedItem) => (
  <div className="card-form-selected">
    <div className="card-form-delete" onClick={(risk) => handleRemove(risk)}>
      x
    </div>
    <div className="line">
      <i className="fas fa-hard-hat mr-2" />
      {risk.name}
    </div>
  </div>
);

export default SavedItems;
