import React from 'react';
import FormInput from './FormInput';
import SearchBar from './searchBar';

const FormList = ({ lifesavers, handleClick, handleSearch }) => {
  // Order the list by name
  const listOrdered = lifesavers.sort((a, b) => {
    const nameA = `${a.first_name} ${a.last_name}`.toLowerCase();
    const nameB = `${b.first_name} ${b.last_name}`.toLowerCase();

    let comparison = 0;
      if (nameA > nameB) {
        comparison = 1;
      } else if (nameA < nameB) {
        comparison = -1;
      }
      return comparison;
  })

  const renderList = listOrdered.map(lifesaver => {
    return(
      <FormInput 
        key={lifesaver.id}
        id={lifesaver.id} 
        handleClick={handleClick} 
        formList = {true} 
        name={`${lifesaver.first_name} ${lifesaver.last_name}`}
      />
    )
  })

  return(
    <div className="form-lifesavers-list form-flex-element">
      <div className="title">
        <p>Liste des sauveteurs de l'entreprise</p>
      </div>
      <SearchBar handleSearch={handleSearch} />
      <fieldset className="form-group check_boxes optional ppsp_lifesavers">
        <legend className="col-form-label pt-0" />
        <input type="hidden" name="ppsp[lifesavers][]" value="" />
        {renderList}
      </fieldset>
  </div>
  )
};

export default FormList;
