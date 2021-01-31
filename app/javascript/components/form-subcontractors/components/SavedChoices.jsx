import React from 'react';
import SavedItem from './SavedItems';

const SavedChoices = ({ subcontractors, handleRemove }) => {
  const renderSavedItem = subcontractors.map((subcontractor) => (
    <SavedItem
      subcontractor={subcontractor}
      key={subcontractor.id}
      handleRemove={handleRemove}
    />
  ));

  return (
    <div className="subcontractors">
      <p className="text-center">
        Les sous-traitants déjà intégrés à mon PPSPS
      </p>
      <div className="flex-database" id="containerSelectedSubcontractors">
        {renderSavedItem}
      </div>
    </div>
  );
};

export default SavedChoices;
