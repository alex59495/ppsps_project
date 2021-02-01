import React from 'react';

const FormInput = ({ altitude_works, handleClick, formList }) => {
  const renderItems = altitude_works.map((altitude_work) => (
    <div
      className="form-check"
      id={`check_ppsp_altitude_works_${altitude_work.id}`}
      key={altitude_work.id}
      onClick={(e) => handleClick(e)}
    >
      <input
        className="form-check-input check_boxes optional"
        type="checkbox"
        value={altitude_work.id}
        name="ppsp[altitude_works][]"
        id={`ppsp_altitude_works_${altitude_work.id}`}
        defaultChecked={!formList}
      />
      <label
        className="form-check-label collection_check_boxes"
        htmlFor={`ppsp_altitude_works_${altitude_work.id}`}
      >
        {`${altitude_work.name}`}
      </label>
    </div>
  ));

  return renderItems;
};

export default FormInput;
