import React, { useState, useEffect } from 'react';
import FormList from './FormList';
import ListSelected from './ListSelected';
import SavedChoices from './SavedChoices';

export interface SiteInstallation {
  id: number;
  name: string;
  mobile: boolean;
}

const App = () : JSX.Element => {
  const [formList, setFormList] = useState<SiteInstallation[]>([]);
  const [addList, setAddList] = useState<SiteInstallation[]>([]);
  const [savedChoices, setSavedChoices] = useState<SiteInstallation[]>([]);
  const [trigger, setTrigger] = useState<number>(0);


  const handleClick = (e : React.MouseEvent & {currentTarget: {parentNode: {parentNode: HTMLElement}}}) : void => {
    e.preventDefault();
    const id = parseInt(e.currentTarget.querySelector('input').value, 10);
    if (
      e.currentTarget.parentNode.parentNode.classList.contains('site_installations')
    ) {
      // Si on est dans la liste des choix, le fait de cliquer ajoute l'élément dans la liste de la selection en cours
      // et le supprime de la liste des choix
      const formListRemove : SiteInstallation[] = formList.filter(
        (site_installation) => site_installation.id !== id
      );
      const addListAdd : SiteInstallation = formList.find(
        (site_installation) => site_installation.id === id
      );
      setFormList(formListRemove);
      setAddList([addListAdd, ...addList]);
    } else {
      // Si on est dans la liste de la selection en cours, le fait de cliquer ajoute l'élément dans la liste des choix
      // et le supprime de la selection en cours
      const addListRemove : SiteInstallation[] = addList.filter(
        (site_installation) => site_installation.id !== id
      );
      const formListAdd : SiteInstallation = addList.find(
        (site_installation) => site_installation.id === id
      );
      setAddList(addListRemove);
      setFormList([formListAdd, ...formList]);
    }
  };

  const url : string = window.location.protocol;

  const ppspsId : string = document.getElementById('react-render-site-installations')
    .dataset.ppsps_id;

  const fetchSiteInstallationsFormList = () : void => {
    fetch(`${url}/api/v1/site_installations?ppsps_id=${ppspsId}`, {
      method: 'GET',
    })
      .then((response) => response.json())
      .then((data) => setFormList(data));
  };

  const fetchSavedSiteInstallation = () : void => {
    fetch(`${url}/api/v1/selected_site_installations?ppsps_id=${ppspsId}`, {
      method: 'GET',
    })
      .then((response) => response.json())
      .then((data) => setSavedChoices(data));
  }

  const handleRemove = async (site_installation) : Promise<void> => {
    await fetch(
      `${url}/api/v1/selected_installations/${site_installation.id}/?ppsps_id=${ppspsId}`,
      {
        method: 'DELETE',
      }
    )
    let count = trigger
    setTrigger(count + 1)
  };

  useEffect(() : void => {
    fetchSiteInstallationsFormList();
    fetchSavedSiteInstallation()
  }, [trigger]);

  return (
    <>
      <SavedChoices
        site_installations={savedChoices}
        handleRemove={handleRemove}
      />
      <div className="form-flex" id="form-site_installations">
        <FormList site_installations={formList} handleClick={handleClick} />
        <ListSelected site_installations={addList} handleClick={handleClick} />
      </div>
    </>
  );
};

export default App;
