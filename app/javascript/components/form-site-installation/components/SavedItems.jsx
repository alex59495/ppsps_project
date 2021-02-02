import React from 'react';

const SavedItems = ({ site_installation, handleRemove }) => (
  <div className="card-form-selected">
    <div
      className="card-form-delete"
      onClick={() => handleRemove(site_installation)}
    >
      x
    </div>
    <div className="line">
      <i className="fas fa-hard-hat mr-2" />
      {site_installation.name}
    </div>
  </div>
);

export default SavedItems;
