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
import reducerSearch from './reducers/search_reducer'


// log the actions
const composeEnhancers = window.__REDUX_DEVTOOLS_EXTENSION_COMPOSE__ || compose;
const middlewares = composeEnhancers(applyMiddleware(logger, reduxPromise));

// Intitial State
const initialState = {
  ppsps: [],
  search: ''
}

// State and reducers
const reducers = combineReducers({
  ppsps: reducerPpsps,
  search: reducerSearch
});

// render an instance of the component in the DOM
ReactDOM.render(
  <Provider store={createStore(reducers, initialState, middlewares)}>
    <ReactApp />
  </Provider>,
  document.getElementById('root')
)