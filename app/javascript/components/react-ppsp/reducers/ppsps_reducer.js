import { SEARCH_QUERY } from '../actions/index'
import { FETCH_PPSPS } from '../actions/index'
import { LOAD_MORE } from '../actions/index'


import { initialState } from '../index'


const reducerPpsps = (state = initialState, action) => {
  switch (action.type) {
    case FETCH_PPSPS: 
      return {
        ...state,
        ppsps: action.payload,
        // Just select the 12 first elements
        selectedPpsps: action.payload.slice(0,12),
        // Reinitialize the infinite scroll when use the search bar
        page: 2,
      }
    case LOAD_MORE:
      return {
        ...state,
        // If the list is not empty before the first search action
        selectedPpsps: state.selectedPpsps.concat(action.payload),
        page: state.page + 1
      }
    case SEARCH_QUERY:
      // Select the Ppsps which reference correpond to the value of search and limit the result to 12 max.
      let count = 0
      const selected = state.ppsps.filter((ppsp) => {
        return ppsp.project_information.reference.toLowerCase().includes(action.search.toLowerCase()) && count++ < 12
      })
      return {
        ...state,
        // Reinitialize the infinite scroll when use the search bar
        page: 2,
        search: action.search,
        selectedPpsps: selected
      }
    default:
      return state;
  }
}

export default reducerPpsps ;
