import React from 'react';
import ReactDOM from 'react-dom';
import App from './components/App'

const reactFormMachines = () => {
  // Identify the user you're visiting (show page) = currrent_user
  if (document.getElementById('machines-form-react')) {
    // render an instance of the component in the DOM
    ReactDOM.render(
        <App />,
      document.getElementById('machines-form-react')
    );
  }
}


export default reactFormMachines;