import React, {FunctionComponent} from 'react';
import FormList from './FormList';
import ListSelected from './ListSelected';
import SavedChoices from './SavedChoices';

export interface AltitudeWork {
  name: string,
  id: number
}

const App:FunctionComponent = () : JSX.Element => {
  const [formList, setFormList] = React.useState <AltitudeWork[]> ([]);
  const [addList, setAddList] = React.useState <AltitudeWork[]> ([]);
  const [savedChoices, setSavedChoices] = React.useState <AltitudeWork[]> ([]);
  const [trigger, setTrigger] = React.useState <number> (0);

  const handleClick = (e) : void => {
    e.preventDefault();
    const id = parseInt(e.currentTarget.querySelector('input').value, 10);
    if (e.currentTarget.parentNode.classList.contains('ppsp_altitude_works')) {
      // Si on est dans la liste des choix, le fait de cliquer ajoute l'élément dans la liste de la selection en cours
      // et le supprime de la liste des choix
      const formListRemove : AltitudeWork[] = formList.filter(
        (altitude_work : AltitudeWork) => altitude_work.id !== id
      );
      const addListAdd : AltitudeWork = formList.find(
        (altitude_work : AltitudeWork) => altitude_work.id === id
      );
      setFormList(formListRemove);
      setAddList([addListAdd, ...addList]);
    } else {
      // Si on est dans la liste de la selection en cours, le fait de cliquer ajoute l'élément dans la liste des choix
      // et le supprime de la selection en cours
      const addListRemove : AltitudeWork[] = addList.filter(
        (altitude_work : AltitudeWork) => altitude_work.id !== id
      );
      const formListAdd : AltitudeWork = addList.find(
        (altitude_work : AltitudeWork) => altitude_work.id === id
      );
      setAddList(addListRemove);
      setFormList([formListAdd, ...formList]);
    }
  };

  const url : string = window.location.protocol;

  const ppspsId : string = document.getElementById('react-render-altitude-works').dataset
    .ppsps_id;

  const fetchAltitudeWorksFormList = () : void => {
    fetch(`${url}/api/v1/altitude_works?ppsps_id=${ppspsId}`, {
      method: 'GET',
    })
      .then((response) => response.json())
      .then((data) => setFormList(data));
  };

  const fetchSavedAltitudeWorks = () : void => {
    fetch(`${url}/api/v1/selected_altitude_works?ppsps_id=${ppspsId}`, {
      method: 'GET',
    })
      .then((response) => response.json())
      .then((data) => setSavedChoices(data));
  }

  const handleRemove = async (altitude_work) => {
    await fetch(
      `${url}/api/v1/selected_altitudes/${altitude_work.id}/?ppsps_id=${ppspsId}`,
      {
        method: 'DELETE',
      }
    );
    let count = trigger
    setTrigger(count + 1)
  };
  
  React.useEffect(() => {
    fetchAltitudeWorksFormList();
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
