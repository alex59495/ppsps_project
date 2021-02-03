import React from 'react';

const FormInput = ({ id, handleClick, formList, name }) => (
    <div
      className="form-check"
      id={`check_ppsp_altitude_works_${id}`}
      onClick={(e) => handleClick(e)}
    >
      <input
        className="form-check-input check_boxes optional"
        type="checkbox"
        value={id}
        name="ppsp[altitude_works][]"
        id={`ppsp_altitude_works_${id}`}
        defaultChecked={!formList}
      />
      <label
        className="form-check-label collection_check_boxes"
        htmlFor={`ppsp_altitude_works_${id}`}
      >
        {name}
      </label>
    </div>
);

export default FormInput;
