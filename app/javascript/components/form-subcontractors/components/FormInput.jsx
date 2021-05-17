import React from 'react';

const FormInput = ({ name, id, responsible_name, work, handleClick, formList }) => (
  <div
    className="form-check"
    id={`check_subcontractors_${id}`}
    onClick={(e) => handleClick(e)}
  >
    <input
      type="checkbox"
      className='hidden'
      value={id}
      name="subcontractors[]"
      id={`subcontractors_${id}`}
      defaultChecked={!formList}
    />
    <label
      className={`form-checkbox-subcontractor ${!formList ? 'active' : ''}`}
      htmlFor={`subcontractors_${id}`}
    >
      <div className='text-center'><b>{name}</b></div>
      <div className="line"><i className="fas fa-user mr-2"></i>{responsible_name}</div>
      <div className="line"><i className="fas fa-tools mr-2"></i>{work}</div>
    </label>
  </div>
)

export default FormInput;
