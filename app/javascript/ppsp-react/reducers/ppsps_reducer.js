import { SEARCH_QUERY } from '../actions/index'
import { FETCH_PPSPS } from '../actions/index'
import { FETCH_USER_PPSPS } from '../actions/index'


import { initialState } from '../index'


const reducerPpsps = (state = initialState, action) => {
  switch (action.type) {
    case FETCH_PPSPS:
      return {
        ...state,
        ppsps: action.payload,
        // If not the list is empty before the first search action
        selectedPpsps: action.payload
      }
    case SEARCH_QUERY:
      // Select the Ppsps which reference correpond to the value of search 
      const selected = state.ppsps.filter((ppsp) => {
        return ppsp.project_information.reference.toLowerCase().includes(action.search.toLowerCase())
      })
      return {
        ...state,
        search: action.search,
        selectedPpsps: selected
      }
    default:
      return state;
  }
}

export default reducerPpsps ;
