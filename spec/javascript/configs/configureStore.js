import {createStore, applyMiddleware } from 'redux';
import ReduxThunk from 'redux-thunk';
import reducerPpsps from '../../../app/javascript/components/react-ppsp/reducers/ppsps_reducer'

export const middlewares = [ReduxThunk];
const createStoreWithMiddleware = applyMiddleware(...middlewares)(createStore);

export default createStoreWithMiddleware(reducerPpsps);