import React from 'react';
import FormInput from './FormInput';

const FormList = ({ risks, handleClick, riskTypes }) => {
  // Order the list by name
  const listOrdered = risks.sort((a, b) => {
    const nameA = a.name.toLowerCase();
    const nameB = b.name.toLowerCase();

    let comparison = 0;
      if (nameA > nameB) {
        comparison = 1;
      } else if (nameA < nameB) {
        comparison = -1;
      }
      return comparison;
  })

  const filterByRiskType = (listOrdered, riskType) => {
    const filteredList =  listOrdered.filter(risk => {
      return risk.categorie === riskType
    })
    const filter = filteredList.map(risk => {
      return(
        <FormInput 
          id={risk.id} 
          name={risk.name} 
          formList = {true}
          handleClick={handleClick}
          key={risk.id}
        />
      )
    })
    return filter
  }

  const handleShow = (e) => {
    document.getElementById(`${e.currentTarget.id}`).classList.toggle('active')
    document.getElementById(`content_${e.currentTarget.id}`).classList.toggle('hidden')
  }

  // .toLowerCase().normalize("NFD").replace(/[\u0300-\u036f]/g, "").replace(/\s/g, '_') is used to transform the string this way :
  // Chantier lié à l'électricté => chantier_lie_a_l_electricite
  const renderList = riskTypes.map(riskType => {
    return(
      <React.Fragment key={riskType}>
        <div className="form-checkbox" onClick={handleShow} id={`risk_type_${riskType.toLowerCase().normalize("NFD").replace(/[\u0300-\u036f]/g, "").replace(/\s/g, '_')}`}>
          {riskType}
        </div>
        <div className='hidden' id={`content_risk_type_${riskType.toLowerCase().normalize("NFD").replace(/[\u0300-\u036f]/g, "").replace(/\s/g, '_')}`}>
          {filterByRiskType(listOrdered, riskType)}
        </div>
      </React.Fragment>
    )
  })

  return (
    <div className="form-risks-list form-flex-element">
      <div className="title">
        <p>Les types de travaux disponibles</p>
      </div>
      <fieldset className="form-group check_boxes optional ppsp_risks">
        <legend className="col-form-label pt-0" />
        <input type="hidden" name="ppsp[risks][]" value="" />
        {renderList}
      </fieldset>
    </div>
  )
}

export default FormList;
