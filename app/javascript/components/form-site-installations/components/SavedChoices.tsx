import React from 'react';
import SavedItem from './SavedItems';

import {SiteInstallation} from './App';

interface PropsSavedChoice {
  site_installations: SiteInstallation[];
  handleRemove: (e: React.MouseEvent) => void;
}

const SavedChoices = ({ site_installations, handleRemove } : PropsSavedChoice) => {
  const renderSavedItem = site_installations.map((site_installation : SiteInstallation) => (
    <SavedItem
      site_installation={site_installation}
      key={site_installation.id}
      handleRemove={handleRemove}
    />
  ));

  const renderTitle = (site_installations : SiteInstallation[]) => {
    if (site_installations.length > 0) {
      return (
        <p className="text-center">
          Les installations déjà intégrés à mon PPSPS
        </p>
      );
    }
  };

  return (
    <div className="site_installations">
      {renderTitle(site_installations)}
      <div className="flex-database" id="containerSelectedSiteInstallations">
        {renderSavedItem}
      </div>
    </div>
  );
};

export default SavedChoices;
