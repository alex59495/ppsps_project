import React from 'react';
import SavedItem from './SavedItems';
import {AltitudeWork} from './App'

interface PropsSavedChoice {
  altitude_works: AltitudeWork[];
  handleRemove: Function;
}

const SavedChoices = ({ altitude_works, handleRemove } : PropsSavedChoice) : JSX.Element => {
  const renderSavedItem = altitude_works.map((altitude_work : AltitudeWork) => (
    <SavedItem
      altitude_work={altitude_work}
      key={altitude_work.id}
      handleRemove={handleRemove}
    />
  ));

  const renderTitle = (altitude_works : AltitudeWork[]) : JSX.Element => {
    if (altitude_works.length > 0) {
      return (
        <p className="text-center">
          Les accès au chantier déjà intégrés à mon PPSPS
        </p>
      );
    }
  };

  return (
    <div className="altitude_works">
      {renderTitle(altitude_works)}
      <div className="flex-database" id="containerSelectedAltitudeWorks">
        {renderSavedItem}
      </div>
    </div>
  );
};

export default SavedChoices;
