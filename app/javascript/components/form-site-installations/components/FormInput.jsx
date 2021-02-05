import React from 'react';

const FormInput = ({ name, id, handleClick, formList }) => (
  <div
    className="form-check"
    id={`check_ppsp_site_installations_${id}`}
    onClick={(e) => handleClick(e)}
  >
    <input
      type="hidden"
      value={id}
      name="ppsp[site_installations][]"
      id={`ppsp_site_installations_${id}`}
      defaultChecked={!formList}
    />
    <label
      className={`form-checkbox ${!formList ? 'active' : ''}`}
      htmlFor={`ppsp_site_installations_${id}`}
    >
      {`${name}`}
    </label>
  </div>
)

export default FormInput;
