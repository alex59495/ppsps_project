import React from 'react';
import FormInput from './FormInput';

const FormList = ({ site_installations, handleClick }) => {
  // Order the list by name
  const listOrdered = site_installations.sort((a, b) => {
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

  const listMobile = listOrdered.filter(site => {
    if(site != undefined) {
      return site.mobile === true
    }
  })

  const listFixe = listOrdered.filter(site => {
    if(site != undefined) {
      return site.mobile === false
    }
  })

  const renderListMobile = listMobile.map(site_installation => {
    return(
      <FormInput
      id={site_installation.id}
      name={site_installation.name}
      handleClick={handleClick}
      formList
      key={site_installation.id}
    />
    )
  })

  const renderListFixe = listFixe.map(site_installation => {
    return(
      <FormInput
      id={site_installation.id}
      name={site_installation.name}
      handleClick={handleClick}
      formList
      key={site_installation.id}
    />
    )
  })

  const handleClickMobile = () => {
    const mobile = document.getElementById('form-site-mobile')
    mobile.classList.toggle('active')
    const listMobile = document.querySelector('.list-mobile')
    listMobile.classList.toggle('hidden')
  }

  const handleClickFixe= () => {
    const fixe = document.getElementById('form-site-fixe')
    fixe.classList.toggle('active')
    const listFixe = document.querySelector('.list-fixe')
    listFixe.classList.toggle('hidden')
  }

  return(
    <div className="form-site_installations-list form-flex-element">
      <div className="title">
        <p>Installations disponibles</p>
      </div>
      <fieldset className="form-group check_boxes optional ppsp_site_installations">
        <legend className="col-form-label pt-0" />
        <input type="hidden" name="ppsp[site_installations][]" value="" />
          <div className="form-checkbox" onClick={handleClickFixe} id='form-site-fixe'>
            Fixe
          </div>
          <div className='list-fixe hidden'>
            {renderListFixe}
          </div>
          <div className="form-checkbox" onClick={handleClickMobile} id='form-site-mobile'>
            Mobile
          </div>
          <div className='list-mobile hidden'>
            {renderListMobile}
          </div>
      </fieldset>
    </div>
  )
}

export default FormList;
