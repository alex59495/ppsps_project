import React from 'react';

import {SiteInstallation} from './App';

interface PropsSavedItem {
  site_installation: SiteInstallation;
  handleRemove: (site_installation: SiteInstallation) => void;
}

const SavedItems = ({ site_installation, handleRemove } : PropsSavedItem) => (
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
