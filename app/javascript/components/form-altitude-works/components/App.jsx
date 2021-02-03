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
    if (e.currentTarget.parentNode.classList.contains('ppsp_altitude_works')) {
      // Si on est dans la liste des choix, le fait de cliquer ajoute l'élément dans la liste de la selection en cours
      // et le supprime de la liste des choix
      const formListRemove = formList.filter(
        (altitude_work) => altitude_work.id !== id
      );
      const addListAdd = formList.find(
        (altitude_work) => altitude_work.id === id
      );
      setFormList(formListRemove);
      setAddList([addListAdd, ...addList]);
    } else {
      // Si on est dans la liste de la selection en cours, le fait de cliquer ajoute l'élément dans la liste des choix
      // et le supprime de la selection en cours
      const addListRemove = addList.filter(
        (altitude_work) => altitude_work.id !== id
      );
      const formListAdd = addList.find(
        (altitude_work) => altitude_work.id === id
      );
      setAddList(addListRemove);
      setFormList([formListAdd, ...formList]);
    }
  };

  const url = window.location.protocol;

  const ppspsId = document.getElementById('react-render-altitude-works').dataset
    .ppsps_id;

  const fetchAltitudeWorksFormList = () => {
    fetch(`${url}/api/v1/altitude_works?ppsps_id=${ppspsId}`, {
      method: 'GET',
    })
      .then((response) => response.json())
      .then((data) => setFormList(data));
  };

  const fetchSavedAltitudeWorks = () => {
    fetch(`${url}/api/v1/selected_altitude_works?ppsps_id=${ppspsId}`, {
      method: 'GET',
    })
      .then((response) => response.json())
      .then((data) => setSavedChoices(data));
  }

  const handleRemove = (altitude_work) => {
    fetch(
      `${url}/api/v1/altitude_works/${altitude_work.id}/?ppsps_id=${ppspsId}`,
      {
        method: 'DELETE',
      }
    );
    let count = trigger
    count =+ 1
    setTrigger(count)
  };

  useEffect(() => {
    fetchAltitudeWorksFormList();
  }, []);

  useEffect(() => {
    fetchSavedAltitudeWorks()
  }, [trigger]);

  return (
    <>
      <SavedChoices altitude_works={savedChoices} handleRemove={handleRemove} />
      <div className="form-flex" id="form-altitude_works">
        <FormList altitude_works={formList} handleClick={handleClick} />
        <ListSelected altitude_works={addList} handleClick={handleClick} />
      </div>
    </>
  );
};

export default App;
