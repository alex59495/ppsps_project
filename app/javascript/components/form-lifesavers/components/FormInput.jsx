import React from 'react';

const FormInput = ({ id, name, handleClick, formList }) => {
  return (
    <div
      className="form-check"
      id={`check_ppsp_lifesavers_${id}`}
      onClick={(e) => handleClick(e)}
    >
      <input
        className="form-check-input check_boxes optional"
        type="checkbox"
        value={id}
        name="ppsp[lifesavers][]"
        id={`ppsp_lifesavers_${id}`}
        defaultChecked={!formList}
      />
      <label
        className="form-check-label collection_check_boxes"
        htmlFor={`ppsp_lifesavers_${id}`}
      >
        {name}
      </label>
    </div>
  );
};

export default FormInput;
