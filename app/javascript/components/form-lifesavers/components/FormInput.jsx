import React from 'react';

const FormInput = ({ id, name, handleClick, formList }) => {
  return (
    <div
      className="form-check"
      id={`check_ppsp_lifesavers_${id}`}
      onClick={(e) => handleClick(e)}
    >
      <input
        type="checkbox"
        className='hidden'
        value={id}
        name="ppsp[lifesavers][]"
        id={`ppsp_lifesavers_${id}`}
        defaultChecked={!formList}
      />
      <label
        className={`form-checkbox ${!formList ? 'active' : ''}`}
        htmlFor={`ppsp_lifesavers_${id}`}
      >
        {name}
      </label>
    </div>
  );
};

export default FormInput;
