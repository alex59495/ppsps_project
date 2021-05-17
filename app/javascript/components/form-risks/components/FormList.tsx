import React from 'react';
import FormInput from './FormInput';
import {Risk} from './App';

interface PropsFormList {
  risks: Risk[];
  handleClick: () => void;
  riskTypes: string[];
}

const FormList = ({ risks, handleClick, riskTypes } : PropsFormList) => {
  // Order the list by name
  const listOrdered : Risk[] = risks.sort((a, b) => {
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

  const filterByRiskType = (listOrdered : Risk[], riskType: string) : JSX.Element[] => {
    const filteredList =  listOrdered.filter((risk : Risk) => {
      return risk.categorie === riskType
    })
    const filter = filteredList.map((risk : Risk) => {
      return(
        <FormInput 
          id={risk.id} 
          name={risk.name} 
          checked = {true}
          handleClick={handleClick}
          key={risk.id}
        />
      )
    })
    return filter
  }

  const handleShow = (e : React.MouseEvent) : void => {
    document.getElementById(`${e.currentTarget.id}`).classList.toggle('active')
    document.getElementById(`content_${e.currentTarget.id}`).classList.toggle('hidden')
  }

  // .toLowerCase().normalize("NFD").replace(/[\u0300-\u036f]/g, "").replace(/\s/g, '_') is used to transform the string this way :
  // Chantier lié à l'électricté => chantier_lie_a_l_electricite
  const renderList = riskTypes.map((riskType : string) : JSX.Element => {
    return(
      <React.Fragment key={riskType}>
        <div className="form-checkbox" onClick={handleShow} id={`risk_type_${riskType.toLowerCase().normalize("NFD").replace(/[\u0300-\u036f]/g, "").replace(/[^A-Z0-9]+/ig, '_')}`}>
          {riskType}
        </div>
        <div className='hidden' id={`content_risk_type_${riskType.toLowerCase().normalize("NFD").replace(/[\u0300-\u036f]/g, "").replace(/[^A-Z0-9]+/ig, '_')}`}>
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
      <fieldset className="form-group check_boxes optional risks">
        <legend className="col-form-label pt-0" />
        <input type="hidden" name="risks[]" value="" />
        {renderList}
      </fieldset>
    </div>
  )
}

export default FormList;
