// External modules
import React from 'react'
import ReactDOM from 'react-dom'
import { Provider } from 'react-redux';
import { createStore, combineReducers, applyMiddleware, compose } from 'redux';
import reduxPromise from 'redux-promise';
import logger from 'redux-logger';

// Internal modules
import ReactApp from './components/react_app'
import reducerPpsps from './reducers/ppsps_reducer'

// log the actions
const composeEnhancers = window.__REDUX_DEVTOOLS_EXTENSION_COMPOSE__ || compose;
const middlewares = composeEnhancers(applyMiddleware(logger, reduxPromise));

// Identifiy currentUser
let current = ''
if(document.getElementById('ppsps-react')) {
  current = document.getElementById('ppsps-react').dataset.current 
}

// Identify the user you're visiting (show page) = currrent_user
let show = ''
if(document.querySelector('.show-user')) {
  show = document.querySelector('.show-user').dataset.usershow 
}

// Intitial State
const initialState = {
  ppsps: [],
  search: '',
  selectedPpsps: [],
  currentUser: current,
  showUser: show,
  page: 2,
}

export { initialState }

// State and reducers
// const reducers = combineReducers({
//   ppsps: reducerPpsps,
//   search: reducerPpsps,
//   selectedPpsps: reducerPpsps
// });

if(document.getElementById('ppsps-react')) {
  document.addEventListener('turbolinks:load', () => {
    // render an instance of the component in the DOM
    ReactDOM.render(
      <Provider store={createStore(reducerPpsps, initialState, middlewares)}>
        <ReactApp />
      </Provider>,
      document.getElementById('ppsps-react')
    )
  })
}