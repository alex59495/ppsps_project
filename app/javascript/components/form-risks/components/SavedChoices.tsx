import React from 'react';
import SavedItem from './SavedItems';
import {Risk} from './App';

interface PropsSavedChoice { 
  risks: Risk[];
  handleRemove: (risk: Risk) => void;
}

const SavedChoices = ({ risks, handleRemove }: PropsSavedChoice) => {
  const renderSavedItem = risks.map((risk : Risk) => (
    <SavedItem risk={risk} key={risk.id} handleRemove={() => handleRemove(risk)} />
  ));

  const renderTitle = (risks : Risk[]) => {
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
