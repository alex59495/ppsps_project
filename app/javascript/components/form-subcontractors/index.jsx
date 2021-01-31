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

const FormSubcontractors = () => {
  // Identify the user you're visiting (show page) = currrent_user
  if (document.getElementById('render-subcontractors')) {
    // render an instance of the component in the DOM
    ReactDOM.render(<App />, document.getElementById('render-subcontractors'));
  }
};

export default FormSubcontractors;
