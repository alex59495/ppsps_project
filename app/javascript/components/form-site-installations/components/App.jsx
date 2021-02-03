import React, { useState, useEffect } from 'react';
import FormList from './FormList';
import ListSelected from './ListSelected';
import SavedChoices from './SavedChoices';

const App = () => {
  const [formList, setFormList] = useState([]);
  const [addList, setAddList] = useState([]);
  const [savedChoices, setSavedChoices] = useState([]);
  const [trigger, setTrigger] = useState(0);


  const handleClick = (e) => {
    e.preventDefault();
    const id = parseInt(e.currentTarget.querySelector('input').value, 10);
    if (
      e.currentTarget.parentNode.classList.contains('ppsp_site_installations')
    ) {
      // Si on est dans la liste des choix, le fait de cliquer ajoute l'élément dans la liste de la selection en cours
      // et le supprime de la liste des choix
      const formListRemove = formList.filter(
        (site_installation) => site_installation.id !== id
      );
      const addListAdd = formList.find(
        (site_installation) => site_installation.id === id
      );
      setFormList(formListRemove);
      setAddList([addListAdd, ...addList]);
    } else {
      // Si on est dans la liste de la selection en cours, le fait de cliquer ajoute l'élément dans la liste des choix
      // et le supprime de la selection en cours
      const addListRemove = addList.filter(
        (site_installation) => site_installation.id !== id
      );
      const formListAdd = addList.find(
        (site_installation) => site_installation.id === id
      );
      setAddList(addListRemove);
      setFormList([formListAdd, ...formList]);
    }
  };

  const url = window.location.protocol;

  const ppspsId = document.getElementById('react-render-site-installations')
    .dataset.ppsps_id;

  const fetchSiteInstallationsFormList = () => {
    fetch(`${url}/api/v1/site_installations?ppsps_id=${ppspsId}`, {
      method: 'GET',
    })
      .then((response) => response.json())
      .then((data) => setFormList(data));
  };

  const fetchSavedSiteInstallation = () => {
    fetch(`${url}/api/v1/selected_site_installations?ppsps_id=${ppspsId}`, {
      method: 'GET',
    })
      .then((response) => response.json())
      .then((data) => setSavedChoices(data));
  }

  const handleRemove = (site_installation) => {
    fetch(
      `${url}/api/v1/site_installations/${site_installation.id}/?ppsps_id=${ppspsId}`,
      {
        method: 'DELETE',
      }
    )
    let count = trigger
    count =+ 1
    setTrigger(count)
  };

  useEffect(() => {
    fetchSiteInstallationsFormList();
  }, []);

  useEffect(() => {
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
