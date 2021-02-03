import React from 'react';
import SavedItem from './SavedItems';

const SavedChoices = ({ lifesavers, handleRemove }) => {
  const renderSavedItem = lifesavers.map((lifesaver) => (
    <SavedItem
      lifesaver={lifesaver}
      key={lifesaver.id}
      handleRemove={handleRemove}
    />
  ));

  const renderTitle = (lifesavers) => {
    if (lifesavers.length > 0) {
      return (
        <p className="text-center">
          Les types de travaux déjà intégrés à mon PPSPS
        </p>
      );
    }
  };

  return (
    <div className="lifesavers">
      {renderTitle(lifesavers)}
      <div className="flex-database" id="containerSelectedAltitudeWorks">
        {renderSavedItem}
      </div>
    </div>
  );
};

export default SavedChoices;
