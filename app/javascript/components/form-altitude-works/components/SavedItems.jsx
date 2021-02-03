import React from 'react';

const SavedItems = ({ altitude_work, handleRemove }) => (
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
