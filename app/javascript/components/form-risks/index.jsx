// External modules
import React from 'react';
import ReactDOM from 'react-dom';

// Internal modules
import App from './components/App';

// State and reducers
// const reducers = combineReducers({
//   ppsps: reducerPpsps,
//   search: reducerPpsps,
//   selectedPpsps: reducerPpsps
// });

const FormRisks = () => {
  // Identify the user you're visiting (show page) = currrent_user
  if (document.getElementById('react-render-risks')) {
    // render an instance of the component in the DOM
    ReactDOM.render(<App />, document.getElementById('react-render-risks'));
  }
};

export default FormRisks;
