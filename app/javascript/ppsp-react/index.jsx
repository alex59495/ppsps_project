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
const current = document.getElementById('root').dataset.current 

// Intitial State
const initialState = {
  ppsps: [],
  search: '',
  selectedPpsps: [],
  currentUser: current
}

export { initialState }

// State and reducers
// const reducers = combineReducers({
//   ppsps: reducerPpsps,
//   search: reducerPpsps,
//   selectedPpsps: reducerPpsps
// });

// render an instance of the component in the DOM
ReactDOM.render(
  <Provider store={createStore(reducerPpsps, initialState, middlewares)}>
    <ReactApp />
  </Provider>,
  document.getElementById('root')
)