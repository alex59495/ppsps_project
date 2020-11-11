import { SEARCH_QUERY } from '../actions/index'


const reducerSearch = (state = null, action) => {
  switch(action.type) {
    case SEARCH_QUERY:
      return action.search
    default:
      return state;
  }
}

export default reducerSearch;