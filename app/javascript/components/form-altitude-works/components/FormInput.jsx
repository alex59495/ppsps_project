import React from 'react';

const FormInput = ({ id, handleClick, formList, name }) => (
    <div
      className="form-check"
      id={`check_altitude_works_${id}`}
      onClick={(e) => handleClick(e)}
    >
      <input
        type="checkbox"
        className='hidden'
        value={id}
        name="altitude_works[]"
        id={`altitude_works_${id}`}
        defaultChecked={!formList}
      />
      <label
        className={`form-checkbox ${!formList ? 'active' : ''}`}
        htmlFor={`altitude_works_${id}`}
      >
        {name}
      </label>
    </div>
);

export default FormInput;
