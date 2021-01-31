import React from 'react';

const SavedItems = ({ subcontractor, handleRemove }) => (
  <div>
    <div className="card-form-selected">
      <div
        className="card-form-delete"
        onClick={() => handleRemove(subcontractor)}
      >
        x
      </div>
      <div className="line">
        <i className="fas fa-hard-hat mr-2" />
        {subcontractor.name}
      </div>
      <div className="line">
        <i className="fas fa-user mr-2" />
        {subcontractor.responsible_name}
      </div>
      <div className="line">
        <i className="fas fa-tools mr-2" />
        {subcontractor.work}
      </div>
    </div>
  </div>
);

export default SavedItems;
