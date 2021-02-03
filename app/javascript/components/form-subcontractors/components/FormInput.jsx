import React from 'react';

const FormInput = ({ name, id, responsible_name, work, handleClick, formList }) => (
  <div
    className="form-check"
    id={`check_ppsp_subcontractors_${id}`}
    key={id}
    onClick={(e) => handleClick(e)}
  >
    <input
      className="form-check-input check_boxes optional"
      type="checkbox"
      value={id}
      name="ppsp[subcontractors][]"
      id={`ppsp_subcontractors_${id}`}
      defaultChecked={!formList}
    />
    <label
      className="form-check-label collection_check_boxes"
      htmlFor={`ppsp_subcontractors_${id}`}
    >
      {`${name} - ${responsible_name} - ${work}`}
    </label>
  </div>
)

export default FormInput;
