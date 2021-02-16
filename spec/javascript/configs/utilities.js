import {createStore, applyMiddleware } from 'redux';

import { middlewares } from './configureStore'
import reducerPpsps from '../../../app/javascript/components/react-ppsp/reducers/ppsps_reducer'

const ppsps = [{
  id: 1,
  project_information: {
    reference: 'AB1234',
  },
  user_first_name: 'Alexis',
  user_last_name: 'Lenoir',
  start_date: '01/01/2020', 
  end_date: '01/01/2021', 
  address: 'Test adress',
  user: {
    full_name: 'Alexis Lenoir'
  }
}, {
  id: 2,
  project_information: {
    reference: 'AB1235',
  },
  user_first_name: 'Maxence',
  user_last_name: 'Lenoir',
  start_date: '01/01/2020', 
  end_date: '01/01/2021', 
  address: 'Test adress',
  user: {
    full_name: 'Maxence Lenoir'
  }
}, {
  id: 3,
  project_information: {
    reference: 'BB1234',
  },
  user_first_name: 'Angelique',
  user_last_name: 'Lenoir',
  start_date: '01/01/2020', 
  end_date: '01/01/2021', 
  address: 'Test adress',
  user: {
    full_name: 'Angelique Lenoir'
  }
}]

// Intitial State
export const initialTestState = {
  ppsps: ppsps,
  search: '',
  selectedPpsps: [],
  currentUser: 1,
  showUser: 1,
  page: 2,
  loading: false,
};

export const storeFactory = (initialState) => {
  const createStoreWithMiddleware = applyMiddleware(...middlewares)(createStore)
  return createStoreWithMiddleware(reducerPpsps, initialState)
}