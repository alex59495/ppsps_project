import React from 'react';
import SavedItem from './SavedItems';

const SavedChoices = ({ site_installations, handleRemove }) => {
  const renderSavedItem = site_installations.map((site_installation) => (
    <SavedItem
      site_installation={site_installation}
      key={site_installation.id}
      handleRemove={handleRemove}
    />
  ));

  const renderTitle = (site_installations) => {
    if (site_installations.length > 0) {
      return (
        <p className="text-center">
          Les types de travaux déjà intégrés à mon PPSPS
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
