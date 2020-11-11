import { FETCH_PPSPS } from '../actions/index'


const reducerPpsps = (state = null, action) => {
  switch (action.type) {
    case FETCH_PPSPS:
      return action.payload
    default:
      return state;
  }
}

export default reducerPpsps;