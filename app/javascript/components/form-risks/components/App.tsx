import React, { useState, useEffect } from 'react';
import FormList from './FormList';
import ListSelected from './ListSelected';
import SavedChoices from './SavedChoices';

export interface Risk {
  id: number;
  name: string;
  categorie: string;
}

const App = () : JSX.Element => {
  const [riskTypes, setRiskTypes] = useState<string[]>([]);
  const [formList, setFormList] = useState<Risk[]>([]);
  const [addList, setAddList] = useState<Risk[]>([]);
  const [savedChoices, setSavedChoices] = useState<Risk[]>([]);
  const [trigger, setTrigger] = useState<number>(0);

  const handleClick = (e) => {
    e.preventDefault();
<<<<<<< HEAD:app/javascript/components/form-risks/components/App.tsx
    const id : number = parseInt(e.currentTarget.querySelector('input').value, 10);
    if (e.currentTarget.parentNode.parentNode.classList.contains('ppsp_risks')) {
=======
    const id = parseInt(e.currentTarget.querySelector('input').value, 10);
    if (e.currentTarget.parentNode.parentNode.classList.contains('risks')) {
>>>>>>> d7c92b24fedda37ca84bd0577d11fab29349f61a:app/javascript/components/form-risks/components/App.jsx
      // Si on est dans la liste des choix, le fait de cliquer ajoute l'élément dans la liste de la selection en cours
      // et le supprime de la liste des choix
      const formListRemove : Risk[] = formList.filter((risk : Risk) => risk.id !== id);
      const addListAdd : Risk = formList.find((risk : Risk) => risk.id === id);
      setFormList(formListRemove);
      setAddList([addListAdd, ...addList]);
    } else {
      // Si on est dans la liste de la selection en cours, le fait de cliquer ajoute l'élément dans la liste des choix
      // et le supprime de la selection en cours
      const addListRemove : Risk[] = addList.filter((risk : Risk) => risk.id !== id);
      const formListAdd : Risk = addList.find((risk : Risk) => risk.id === id);
      setAddList(addListRemove);
      setFormList([formListAdd, ...formList]);
    }
  };

  const url : string = window.location.protocol;

  const ppspsId : string = document.getElementById('react-render-risks').dataset
    .ppsps_id;

  const fetchrisksFormList = () : void => {
    fetch(`${url}/api/v1/risks?ppsps_id=${ppspsId}`, {
      method: 'GET',
    })
      .then((response) => response.json())
      .then((data) => {
        setFormList(data)
        // On ne récupère que les valeurs uniques pour les types de risques
        const riskTypeUnique : string[] = Array.from(new Set(data.map((risk : Risk) => risk.categorie)));
        setRiskTypes(riskTypeUnique);
      });
  };

  const fetchSavedRisks = () : void => {
    fetch(`${url}/api/v1/selected_risks?ppsps_id=${ppspsId}`, {
      method: 'GET',
    })
      .then((response) => response.json())
      .then((data) => setSavedChoices(data));
  }

  const handleRemove = async (risk) : Promise<void> => {
    await fetch(`${url}/api/v1/selected_risks/${risk.id}/?ppsps_id=${ppspsId}`, {
      method: 'DELETE',
    });
    let count = trigger
    setTrigger(count + 1)
  };

  useEffect(() : void => {
    fetchSavedRisks();
    fetchrisksFormList();
  }, [trigger]);

  return (
    <>
      <SavedChoices risks={savedChoices} handleRemove={handleRemove} />
      <div className="form-flex" id="form-risks">
        <FormList risks={formList} handleClick={handleClick} riskTypes={riskTypes} />
        <ListSelected risks={addList} handleClick={handleClick} />
      </div>
    </>
  );
};

export default App;
