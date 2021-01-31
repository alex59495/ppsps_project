import React from 'react';

const FormInput = ({ subcontractors, handleClick, formList }) => {
  const renderItems = subcontractors.map((subcontractor) => (
    <div
      className="form-check"
      id={`check_ppsp_subcontractors_${subcontractor.id}`}
      key={subcontractor.id}
      onClick={(e) => handleClick(e)}
    >
      <input
        className="form-check-input check_boxes optional"
        type="checkbox"
        value={subcontractor.id}
        name="ppsp[subcontractors][]"
        id={`ppsp_subcontractors_${subcontractor.id}`}
        defaultChecked={!formList}
      />
      <label
        className="form-check-label collection_check_boxes"
        htmlFor={`ppsp_subcontractors_${subcontractor.id}`}
      >
        {`${subcontractor.name} - ${subcontractor.responsible_name} - ${subcontractor.work}`}
      </label>
    </div>
  ));

  return renderItems;
};

export default FormInput;
