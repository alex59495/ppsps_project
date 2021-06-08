import React from 'react';
import {AltitudeWork} from './App';

interface PropsFormInput {
  id: number;
  handleClick: Function;
  checked: boolean;
  name: string;
}

const FormInput = ({ id, handleClick, checked, name } : PropsFormInput) : JSX.Element => (
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
        defaultChecked={!checked}
      />
      <label
        className={`form-checkbox ${!checked ? 'active' : ''}`}
        htmlFor={`altitude_works_${id}`}
      >
        {name}
      </label>
    </div>
);

export default FormInput;
