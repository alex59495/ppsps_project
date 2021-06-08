import React, { ChangeEventHandler } from 'react';
import FormInput from './FormInput';
import SearchBar from './Searchbar';

import {Subcontractor} from './App';

interface PropsFormList {
  subcontractors: Subcontractor[];
  handleClick: (e : React.MouseEvent) => void;
  handleSearch: ChangeEventHandler<Element>
}

const FormList = ({ subcontractors, handleClick, handleSearch } : PropsFormList) : JSX.Element => {
  // Order the list by name
  const listOrdered = subcontractors.sort((a : Subcontractor, b : Subcontractor) => {
    const nameA = `${a.name} - ${a.responsible_name} - ${a.work}`.toLowerCase();
    const nameB = `${b.name} - ${b.responsible_name} - ${b.work}`.toLowerCase();

    let comparison = 0;
      if (nameA > nameB) {
        comparison = 1;
      } else if (nameA < nameB) {
        comparison = -1;
      }
      return comparison;
  })

  const renderList : JSX.Element[] = listOrdered.map((subcontractor : Subcontractor) => {
    return(
      <FormInput
        id={subcontractor.id}
        name={subcontractor.name}
        responsible_name={subcontractor.responsible_name}
        work={subcontractor.work}
        handleClick={handleClick}
        key={subcontractor.id}
        checked = {true}
      />
    )
  })

  return(
    <div className="form-subcontractors-list form-flex-element">
      <div className="title">
        <p>Les sous-traitants disponibles</p>
      </div>
      <SearchBar handleSearch={handleSearch} />
      <fieldset className="form-group check_boxes optional subcontractors">
        <legend className="col-form-label pt-0" />
        <input type="hidden" name="subcontractors[]" value="" />
        {renderList}
      </fieldset>
    </div>
  )
}

export default FormList;
