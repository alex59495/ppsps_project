import React from 'react';

import {SiteInstallation} from './App';

interface PropsFormInput {
  name: string;
  id: number;
  handleClick: (e : React.MouseEvent) => void;
  checked: boolean;
  mobile?: string;
}

const FormInput = ({ name, id, handleClick, checked, mobile }: PropsFormInput) => (
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
      defaultChecked={!checked}
    />
    <label
      className={`form-checkbox ${!checked ? 'active' : ''}`}
      htmlFor={`site_installations_${id}`}
    >
      {mobile ? `${name} - ${mobile}` : `${name}`}
    </label>
  </div>
)

export default FormInput;
