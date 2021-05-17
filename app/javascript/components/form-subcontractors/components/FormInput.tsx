import React from 'react';

interface PropsFormInput {
  name: string;
  id: number;
  responsible_name: string;
  work: string;
  handleClick: (e: React.MouseEvent) => void;
  checked: boolean;
}

const FormInput = ({ name, id, responsible_name, work, handleClick, checked } : PropsFormInput) => (
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
      defaultChecked={!checked}
    />
    <label
      className={`form-checkbox-subcontractor ${!checked ? 'active' : ''}`}
      htmlFor={`ppsp_subcontractors_${id}`}
    >
      <div className='text-center'><b>{name}</b></div>
      <div className="line"><i className="fas fa-user mr-2"></i>{responsible_name}</div>
      <div className="line"><i className="fas fa-tools mr-2"></i>{work}</div>
    </label>
  </div>
)

export default FormInput;
