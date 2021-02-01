import React from 'react';

const FormInput = ({ site_installations, handleClick, formList }) => {
  const renderItems = site_installations.map((site_installation) => (
    <div
      className="form-check"
      id={`check_ppsp_site_installations_${site_installation.id}`}
      key={site_installation.id}
      onClick={(e) => handleClick(e)}
    >
      <input
        className="form-check-input check_boxes optional"
        type="checkbox"
        value={site_installation.id}
        name="ppsp[site_installations][]"
        id={`ppsp_site_installations_${site_installation.id}`}
        defaultChecked={!formList}
      />
      <label
        className="form-check-label collection_check_boxes"
        htmlFor={`ppsp_site_installations_${site_installation.id}`}
      >
        {`${site_installation.name}`}
      </label>
    </div>
  ));

  return renderItems;
};

export default FormInput;
