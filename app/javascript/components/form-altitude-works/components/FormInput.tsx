import React from 'react';
import {AltitudeWork} from './App';

interface PropsFormInput {
  id: number;
  handleClick: Function;
  formList: AltitudeWork[];
  name: string;
}

const FormInput = ({ id, handleClick, formList, name } : PropsFormInput) : JSX.Element => (
    <div
      className="form-check"
      id={`check_ppsp_altitude_works_${id}`}
      onClick={(e) => handleClick(e)}
    >
      <input
        type="checkbox"
        className='hidden'
        value={id}
        name="ppsp[altitude_works][]"
        id={`ppsp_altitude_works_${id}`}
        defaultChecked={!formList}
      />
      <label
        className={`form-checkbox ${!formList ? 'active' : ''}`}
        htmlFor={`ppsp_altitude_works_${id}`}
      >
        {name}
      </label>
    </div>
);

export default FormInput;
