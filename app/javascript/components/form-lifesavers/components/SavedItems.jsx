import React from 'react';

const SavedItems = ({ lifesaver, handleRemove }) => (
  <div className="card-form-selected">
    <div
      className="card-form-delete"
      onClick={() => handleRemove(lifesaver)}
    >
      x
    </div>
    <div className="line">
      <i className="fas fa-hard-hat mr-2" />
      {`${lifesaver.first_name} ${lifesaver.last_name}`}
    </div>
  </div>
);

export default SavedItems;
