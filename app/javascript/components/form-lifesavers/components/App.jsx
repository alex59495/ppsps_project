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
    if (e.currentTarget.parentNode.classList.contains('ppsp_lifesavers')) {
      // Si on est dans la liste des choix, le fait de cliquer ajoute l'élément dans la liste de la selection en cours
      // et le supprime de la liste des choix
      const formListRemove = formList.filter(
        (lifesaver) => lifesaver.id !== id
      );
      const addListAdd = formList.find(
        (lifesaver) => lifesaver.id === id
      );
      setFormList(formListRemove);
      setAddList([addListAdd, ...addList]);
    } else {
      // Si on est dans la liste de la selection en cours, le fait de cliquer ajoute l'élément dans la liste des choix
      // et le supprime de la selection en cours
      const addListRemove = addList.filter(
        (lifesaver) => lifesaver.id !== id
      );
      const formListAdd = addList.find(
        (lifesaver) => lifesaver.id === id
      );
      setAddList(addListRemove);
      setFormList([formListAdd, ...formList]);
    }
  };

  const url = window.location.protocol;

  const ppspsId = document.getElementById('react-render-altitude-works').dataset
    .ppsps_id;

  const fetchLifesaversFormList = () => {
    fetch(`${url}/api/v1/workers/lifesavers?ppsps_id=${ppspsId}`, {
      method: 'GET',
    })
      .then((response) => response.json())
      .then((data) => setFormList(data));
  };

  const fetchSavedLifesaver = () => {
    fetch(`${url}/api/v1/workers/selected_lifesavers?ppsps_id=${ppspsId}`, {
      method: 'GET',
    })
      .then((response) => response.json())
      .then((data) => setSavedChoices(data));
  };

  const handleRemove = (lifesaver) => {
    fetch(
      `${url}/api/v1/workers/lifesavers/${lifesaver.id}/?ppsps_id=${ppspsId}`,
      {
        method: 'DELETE',
      }
    );
    let count = trigger
    count =+ 1
    setTrigger(count)
  };

  useEffect(() => {
    fetchLifesaversFormList();
  }, [])

  useEffect(() => {
    fetchSavedLifesaver();
  }, [trigger]);

  return (
    <>
      <SavedChoices lifesavers={savedChoices} handleRemove={handleRemove} />
      <div className="form-flex" id="form-lifesavers">
        <FormList lifesavers={formList} handleClick={handleClick} />
        <ListSelected lifesavers={addList} handleClick={handleClick} />
      </div>
    </>
  );
};

export default App;
