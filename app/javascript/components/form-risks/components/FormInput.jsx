import React from 'react';

const FormInput = ({ id, name, handleClick, formList }) => (
  <div
    className="form-check"
    id={`check_ppsp_risks_${id}`}
    onClick={(e) => handleClick(e)}
  >
    <input
      type="checkbox"
      className='hidden'
      value={id}
      name="ppsp[risks][]"
      id={`ppsp_risks_${id}`}
      defaultChecked={!formList}
    />
    <label
      className={`form-checkbox ${!formList ? 'active' : ''}`}
      htmlFor={`ppsp_risks_${id}`}
    >
      {`${name}`}
    </label>
  </div>
);

export default FormInput;
