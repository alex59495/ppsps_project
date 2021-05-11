import React from 'react';

const FormInput = ({ id, name, handleClick, formList }) => {
  return (
    <div
      className="form-check"
      id={`check_lifesavers_${id}`}
      onClick={(e) => handleClick(e)}
    >
      <input
        type="checkbox"
        className='hidden'
        value={id}
        name="lifesavers[]"
        id={`lifesavers_${id}`}
        defaultChecked={!formList}
      />
      <label
        className={`form-checkbox ${!formList ? 'active' : ''}`}
        htmlFor={`lifesavers_${id}`}
      >
        {name}
      </label>
    </div>
  );
};

export default FormInput;
