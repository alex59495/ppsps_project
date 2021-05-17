import React from 'react';
import {Risk} from './App';

interface PropsFormInput {
  id: number;
  name: string;
  handleClick: (e : React.MouseEvent<HTMLDivElement>) => void;
  checked: boolean
}

const FormInput = ({ id, name, handleClick, checked } : PropsFormInput) => (
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
      defaultChecked={!checked}
    />
    <label
      className={`form-checkbox ${!checked ? 'active' : ''}`}
      htmlFor={`ppsp_risks_${id}`}
    >
      {`${name}`}
    </label>
  </div>
);

export default FormInput;
