import React from 'react';

const FormInput = ({ name, id, handleClick, formList, mobile }) => (
  <div
    className="form-check"
    id={`check_site_installations_${id}`}
    onClick={(e) => handleClick(e)}
  >
    <input
      type="checkbox"
      className='hidden'
      value={id}
      name="site_installations[]"
      id={`site_installations_${id}`}
      defaultChecked={!formList}
    />
    <label
      className={`form-checkbox ${!formList ? 'active' : ''}`}
      htmlFor={`site_installations_${id}`}
    >
      {mobile ? `${name} - ${mobile}` : `${name}`}
    </label>
  </div>
)

export default FormInput;
