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
    if (e.currentTarget.parentNode.classList.contains('ppsp_subcontractors')) {
      // Si on est dans la liste des choix, le fait de cliquer ajoute l'élément dans la liste de la selection en cours
      // et le supprime de la liste des choix
      const formListRemove = formList.filter(
        (subcontractor) => subcontractor.id !== id
      );
      const addListAdd = formList.find(
        (subcontractor) => subcontractor.id === id
      );
      setFormList(formListRemove);
      setAddList([addListAdd, ...addList]);
    } else {
      // Si on est dans la liste de la selection en cours, le fait de cliquer ajoute l'élément dans la liste des choix
      // et le supprime de la selection en cours
      const addListRemove = addList.filter(
        (subcontractor) => subcontractor.id !== id
      );
      const formListAdd = addList.find(
        (subcontractor) => subcontractor.id === id
      );
      setAddList(addListRemove);
      setFormList([formListAdd, ...formList]);
    }
  };

  const url = window.location.protocol;

  const ppspsId = document.getElementById('react-render-subcontractors').dataset
    .ppsps_id;

  const fetchSubcontractorsFormList = () => {
    fetch(`${url}/api/v1/subcontractors?ppsps_id=${ppspsId}`, {
      method: 'GET',
    })
      .then((response) => response.json())
      .then( async (subcontractors) => {
        const addListIds = addList.map(subcontractor => subcontractor.id) || []
        // On filtre le fetching pour ne pas fetcher les éléments déjà sélectionnés par l'utilisateur
        const arrayResult = await subcontractors.filter(subcontractor => {
          return !addListIds.includes(subcontractor.id)
        })
        setFormList(arrayResult)
      });
  };

  const fetchSavedSubcontractors = () => {
    fetch(`${url}/api/v1/selected_subcontractors?ppsps_id=${ppspsId}`, {
      method: 'GET',
    })
      .then((response) => response.json())
      .then((data) => setSavedChoices(data));
  }

  const handleRemove = async (subcontractor) => {
    await fetch(
      `${url}/api/v1/selected_subcontractors/${subcontractor.id}/?ppsps_id=${ppspsId}`,
      {
        method: 'DELETE',
      }
    );
    let count = trigger
    setTrigger(count + 1)
  };

  useEffect(() => {
    fetchSubcontractorsFormList();
    fetchSavedSubcontractors();
  }, [trigger]);


  // We have to re-render the list if a user add a new sbucontractor (Handled by Ruby), in this case we'll add a 
  // fetch when the user click on the submit Subcontractor New form (wether the form is submitted or not)
  const btnAddSubcontractor = document.getElementById('SubcontractorBtn');
  btnAddSubcontractor.addEventListener('click', () => {
    fetchSubcontractorsFormList();
  })

  return (
    <>
      <SavedChoices subcontractors={savedChoices} handleRemove={handleRemove} />
      <div className="form-flex" id="form-subcontractors">
        <FormList subcontractors={formList} handleClick={handleClick} />
        <ListSelected subcontractors={addList} handleClick={handleClick} />
      </div>
    </>
  );
};

export default App;
