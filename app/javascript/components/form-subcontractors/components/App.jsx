import React, { useState, useEffect } from 'react';
import FormList from './FormList';
import ListSelected from './ListSelected';
import SavedChoices from './SavedChoices';
import ButtonAdd from './ButtonAdd';

const App = ({token}) => {
  const [formList, setFormList] = useState([]);
  const [formListSearched, setFormListSearched] = useState(formList);
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
      const formListSearchedRemove = formListSearched.filter(
        (lifesaver) => lifesaver.id !== id
      );
      // On retire des deux FormList l'option qui vient d'être selectionné pour ne pas qu'elle apparaisse dans le handleSearch
      setFormListSearched(formListSearchedRemove);
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
      // On ajoute dans les deux FormList l'option qui vient d'être selectionné pour qu'elle apparaisse dans le handleSearch
      setAddList(addListRemove);
      setFormListSearched([formListAdd, ...formList]);
      setFormListSearched([formListAdd, ...formListSearched]);
    }
  };

  const url = window.location.protocol;

  const ppspsId = document.getElementById('react-render-subcontractors').dataset
    .ppsps_id;

  const admin = document.getElementById('react-render-subcontractors').dataset
    .admin;

  const fetchSubcontractorsFormList = async () => {
    const response = await fetch(`${url}/api/v1/list_subcontractors?ppsps_id=${ppspsId}`, {
      method: 'GET',
    })
    const arrayFull = await response.json()

    // On filtre le fetching pour ne pas fetcher les éléments déjà sélectionnés par l'utilisateur
    const addListIds = await addList.map(subcontractor => subcontractor.id) || []
    const arrayResult = await arrayFull.filter(subcontractor => {
      return !addListIds.includes(subcontractor.id)
    })

    // On initialise les deux listes, la première servira de "base" et la seconde cherchera dans la première quand on tape quelque chose dans la seachbar
    setFormList(arrayResult)
    setFormListSearched(arrayResult)
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

  // SearchBar
  const handleSearch = async (e) => {
    const search = e.currentTarget.value
    const searched = await formList.filter(subcontractor => {
      return subcontractor.name.toLowerCase().includes(search.toLowerCase()) || subcontractor.work.toLowerCase().includes(search.toLowerCase()) || subcontractor.responsible_name.toLowerCase().includes(search.toLowerCase()) 
    })
    setFormListSearched(searched);
  }

  useEffect(() => {
    fetchSubcontractorsFormList();
    fetchSavedSubcontractors();
  }, [trigger]);

  return (
    <>
      <ButtonAdd admin={admin} url={url} token={token} fetchSubcontractorsFormList={fetchSubcontractorsFormList}/>
      <SavedChoices subcontractors={savedChoices} handleRemove={handleRemove} />
      <div className="form-flex" id="form-subcontractors">
        <FormList subcontractors={formListSearched} handleClick={handleClick} handleSearch={handleSearch}/>
        <ListSelected subcontractors={addList} handleClick={handleClick} />
      </div>
    </>
  );
};

export default App;
