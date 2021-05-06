import React, { useState, useEffect } from 'react';
import FormList from './FormList';
import ListSelected from './ListSelected';
import SavedChoices from './SavedChoices';
import {Worker} from '../../form-conductors/components/App'

const App = () => {
  const [formList, setFormList] = useState<Worker[]>([]);
  const [formListSearched, setFormListSearched] = useState<Worker[]>([]);
  const [addList, setAddList] = useState<Worker[]>([]);
  const [savedChoices, setSavedChoices] = useState<Worker[]>([]);
  const [trigger, setTrigger] = useState<number>(0);

  const handleClick = (e) => {
    e.preventDefault();
    const id : number = parseInt(e.currentTarget.querySelector('input').value, 10);
    if (e.currentTarget.parentNode.classList.contains('ppsp_lifesavers')) {
      // Si on est dans la liste des choix, le fait de cliquer ajoute l'élément dans la liste de la selection en cours
      // et le supprime de la liste des choix
      const formListRemove = formList.filter(
        (lifesaver : Worker) => lifesaver.id !== id
      );
      const addListAdd = formList.find(
        (lifesaver : Worker) => lifesaver.id === id
      );
      const formListSearchedRemove = formListSearched.filter(
        (lifesaver : Worker) => lifesaver.id !== id
      );
      // On retire des deux FormList l'option qui vient d'être selectionné pour ne pas qu'elle apparaisse dans le handleSearch
      setFormListSearched(formListSearchedRemove);
      setFormList(formListRemove);
      setAddList([addListAdd, ...addList]);
    } else {
      // Si on est dans la liste de la selection en cours, le fait de cliquer ajoute l'élément dans la liste des choix
      // et le supprime de la selection en cours
      const addListRemove = addList.filter(
        (lifesaver : Worker) => lifesaver.id !== id
      );
      const formListAdd = addList.find(
        (lifesaver : Worker) => lifesaver.id === id
      );
      // On ajoute dans les deux FormList l'option qui vient d'être selectionné pour qu'elle apparaisse dans le handleSearch
      setAddList(addListRemove);
      setFormListSearched([formListAdd, ...formListSearched]);
      setFormList([formListAdd, ...formList]);
    }
  };

  const url : string = window.location.protocol;

  const ppspsId : string = document.getElementById('react-render-altitude-works').dataset
    .ppsps_id;

  const fetchLifesaversFormList = () : void => {
    fetch(`${url}/api/v1/workers/lifesavers?ppsps_id=${ppspsId}`, {
      method: 'GET',
    })
      .then((response) => response.json())
      .then((data : Worker[]) => {
        // On initialise les deux listes, la première servira de "base" et la seconde cherchera dans la première quand on tape quelque chose dans la seachbar
        setFormList(data)
        setFormListSearched(data)
      });
  };

  const fetchSavedLifesaver = () => {
    fetch(`${url}/api/v1/workers/selected_lifesavers?ppsps_id=${ppspsId}`, {
      method: 'GET',
    })
      .then((response) => response.json())
      .then((data : Worker[]) => setSavedChoices(data));
  };

  const handleRemove = async (lifesaver : Worker) => {
    await fetch(
      `${url}/api/v1/selected_lifesavers/${lifesaver.id}/?ppsps_id=${ppspsId}`,
      {
        method: 'DELETE',
      }
    );
    let count = trigger
    setTrigger(count + 1)
  };

  const handleSearch = (e : MouseEvent) : void => {
    const element = e.currentTarget as HTMLInputElement
    const search = element.value;
    const searched = formList.filter((lifesaver : Worker) => {
      return (lifesaver.first_name.toLowerCase().includes(search.toLowerCase()) || 
        lifesaver.last_name.toLowerCase().includes(search.toLowerCase()) ||
        `${lifesaver.last_name} ${lifesaver.first_name}`.toLowerCase().includes(search.toLowerCase()) ||
        `${lifesaver.first_name} ${lifesaver.last_name}`.toLowerCase().includes(search.toLowerCase())
      )
    })
    setFormListSearched(searched)
  }
  
  useEffect(() => {
    fetchLifesaversFormList();
    fetchSavedLifesaver();
  }, [trigger]);

  return (
    <>
      <SavedChoices lifesavers={savedChoices} handleRemove={handleRemove} />
      <div className="form-flex" id="form-lifesavers">
        <FormList lifesavers={formListSearched} handleClick={handleClick} handleSearch={handleSearch} />
        <ListSelected lifesavers={addList} handleClick={handleClick} />
      </div>
    </>
  );
};

export default App;
