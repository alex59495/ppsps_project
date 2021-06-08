import React from 'react';
import FormInput from './FormInput';

import {SiteInstallation} from './App';

interface PropsFormList {
  site_installations: SiteInstallation[];
  handleClick: (e : React.MouseEvent) => void;
}

const FormList = ({ site_installations, handleClick } : PropsFormList) => {
  // Order the list by name
  const listOrdered : SiteInstallation[] = site_installations.sort((a : SiteInstallation, b : SiteInstallation) => {
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

  const listMobile : SiteInstallation[] = listOrdered.filter((site : SiteInstallation) => {
    if(site != undefined) {
      return site.mobile === true
    }
  })

  const listFixe : SiteInstallation[] = listOrdered.filter((site : SiteInstallation) => {
    if(site != undefined) {
      return site.mobile === false
    }
  })

  const renderListMobile : JSX.Element[] = listMobile.map((site_installation : SiteInstallation) => {
    return(
      <FormInput
        id={site_installation.id}
        name={site_installation.name}
        handleClick={handleClick}
        checked = {true}
        key={site_installation.id}
      />
    )
  })

  const renderListFixe : JSX.Element[] = listFixe.map((site_installation : SiteInstallation) => {
    return(
      <FormInput
        id={site_installation.id}
        name={site_installation.name}
        handleClick={handleClick}
        checked = {true}
        key={site_installation.id}
      />
    )
  })

  const handleClickMobile = () : void => {
    const mobile = document.getElementById('form-site-mobile')
    mobile.classList.toggle('active')
    const listMobile = document.querySelector('.list-mobile')
    listMobile.classList.toggle('hidden')
  }

  const handleClickFixe= () : void => {
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
      <fieldset className="form-group check_boxes optional site_installations">
        <legend className="col-form-label pt-0" />
        <input type="hidden" name="site_installations[]" value="" />
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
