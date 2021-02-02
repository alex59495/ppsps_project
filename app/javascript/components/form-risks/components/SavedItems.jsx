import React from 'react';

const SavedItems = ({ risk, handleRemove }) => (
  <div className="card-form-selected">
    <div className="card-form-delete" onClick={() => handleRemove(risk)}>
      x
    </div>
    <div className="line">
      <i className="fas fa-hard-hat mr-2" />
      {risk.name}
    </div>
  </div>
);

export default SavedItems;
