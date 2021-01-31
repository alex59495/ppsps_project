// External modules
import React from 'react';
import ReactDOM from 'react-dom';

// Internal modules
import ReactApp from './components/react_app';

// State and reducers
// const reducers = combineReducers({
//   ppsps: reducerPpsps,
//   search: reducerPpsps,
//   selectedPpsps: reducerPpsps
// });

const reactPpsp = () => {
  // Identify the user you're visiting (show page) = currrent_user
  if (document.getElementById('render-subcontractors')) {
    // render an instance of the component in the DOM
    ReactDOM.render(
        <ReactApp />
      document.getElementById('render-subcontractors')
    );
  }
};

export default reactPpsp;
