// External modules
import React from 'react'
import ReactDOM from 'react-dom'
import { Provider } from 'react-redux';
import { createStore, combineReducers, applyMiddleware, compose } from 'redux';
import reduxPromise from 'redux-promise';
import logger from 'redux-logger';

// Internal modules
import ListPpsp from './components/list_ppsp'
import PpspsReducer from './reducers/ppsps_reducer'

// log the actions
const composeEnhancers = window.__REDUX_DEVTOOLS_EXTENSION_COMPOSE__ || compose;
const middlewares = composeEnhancers(applyMiddleware(logger, reduxPromise));

// Intitial State
const initialState = {
  ppsps: []
}

// State and reducers
const reducers = combineReducers({
  ppsps: PpspsReducer,
});

// render an instance of the component in the DOM
ReactDOM.render(
  <Provider store={createStore(reducers, initialState, middlewares)}>
    <ListPpsp />
  </Provider>,
  document.getElementById('root')
)