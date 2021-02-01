import React from 'react';
import SavedItem from './SavedItems';

const SavedChoices = ({ risks, handleRemove }) => {
  const renderSavedItem = risks.map((risk) => (
    <SavedItem risk={risk} key={risk.id} handleRemove={handleRemove} />
  ));

  const renderTitle = (risks) => {
    if (risks.length > 0) {
      return (
        <p className="text-center">
          Les types de travaux déjà intégrés à mon PPSPS
        </p>
      );
    }
  };

  return (
    <div className="risks">
      {renderTitle(risks)}
      <div className="flex-database" id="containerSelectedRisks">
        {renderSavedItem}
      </div>
    </div>
  );
};

export default SavedChoices;
