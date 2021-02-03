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
    if (e.currentTarget.parentNode.classList.contains('ppsp_risks')) {
      // Si on est dans la liste des choix, le fait de cliquer ajoute l'élément dans la liste de la selection en cours
      // et le supprime de la liste des choix
      const formListRemove = formList.filter((risk) => risk.id !== id);
      const addListAdd = formList.find((risk) => risk.id === id);
      setFormList(formListRemove);
      setAddList([addListAdd, ...addList]);
    } else {
      // Si on est dans la liste de la selection en cours, le fait de cliquer ajoute l'élément dans la liste des choix
      // et le supprime de la selection en cours
      const addListRemove = addList.filter((risk) => risk.id !== id);
      const formListAdd = addList.find((risk) => risk.id === id);
      setAddList(addListRemove);
      setFormList([formListAdd, ...formList]);
    }
  };

  const url = window.location.protocol;

  const ppspsId = document.getElementById('react-render-risks').dataset
    .ppsps_id;

  const fetchrisksFormList = () => {
    fetch(`${url}/api/v1/risks?ppsps_id=${ppspsId}`, {
      method: 'GET',
    })
      .then((response) => response.json())
      .then((data) => setFormList(data));
  };

  const fetchSavedRisks = () => {
    fetch(`${url}/api/v1/selected_risks?ppsps_id=${ppspsId}`, {
      method: 'GET',
    })
      .then((response) => response.json())
      .then((data) => setSavedChoices(data));
  }

  const handleRemove = (risk) => {
    fetch(`${url}/api/v1/risks/${risk.id}/?ppsps_id=${ppspsId}`, {
      method: 'DELETE',
    });
    let count = trigger
    count =+ 1
    setTrigger(count)
  };

  useEffect(() => {
    fetchrisksFormList();
  }, []);

  useEffect(() => {
    fetchSavedRisks();
  }, [trigger]);

  return (
    <>
      <SavedChoices risks={savedChoices} handleRemove={handleRemove} />
      <div className="form-flex" id="form-risks">
        <FormList risks={formList} handleClick={handleClick} />
        <ListSelected risks={addList} handleClick={handleClick} />
      </div>
    </>
  );
};

export default App;
