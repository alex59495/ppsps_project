import React from 'react';

const FormInput = ({ name, id, responsible_name, work, handleClick, formList }) => (
  <div
    className="form-check"
    id={`check_ppsp_subcontractors_${id}`}
    onClick={(e) => handleClick(e)}
  >
    <input
      type="checkbox"
      className='hidden'
      value={id}
      name="ppsp[subcontractors][]"
      id={`ppsp_subcontractors_${id}`}
      defaultChecked={!formList}
    />
    <label
      className={`form-checkbox ${!formList ? 'active' : ''}`}
      htmlFor={`ppsp_subcontractors_${id}`}
    >
      {`${name} - ${responsible_name} - ${work}`}
    </label>
  </div>
)

export default FormInput;
