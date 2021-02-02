import React from 'react';

const FormInput = ({ risks, handleClick, formList }) => {
  const renderItems = risks.map((risk) => (
    <div
      className="form-check"
      id={`check_ppsp_risks_${risk.id}`}
      key={risk.id}
      onClick={(e) => handleClick(e)}
    >
      <input
        className="form-check-input check_boxes optional"
        type="checkbox"
        value={risk.id}
        name="ppsp[risks][]"
        id={`ppsp_risks_${risk.id}`}
        defaultChecked={!formList}
      />
      <label
        className="form-check-label collection_check_boxes"
        htmlFor={`ppsp_risks_${risk.id}`}
      >
        {`${risk.name}`}
      </label>
    </div>
  ));

  return renderItems;
};

export default FormInput;
