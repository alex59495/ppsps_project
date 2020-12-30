import { SEARCH_QUERY, FETCH_PPSPS, LOAD_MORE } from '../actions/index';

import { initialState } from '../index';

const reducerPpsps = (state = initialState, action) => {
  switch (action.type) {
    case FETCH_PPSPS:
      return {
        ...state,
        ppsps: action.payload,
        // Just select the 12 first elements
        selectedPpsps: action.payload.slice(0, 12),
        // Reinitialize the infinite scroll when use the search bar
        page: 2,
      };
    case LOAD_MORE:
      return {
        ...state,
        // If the list is not empty before the first search action
        selectedPpsps: state.selectedPpsps.concat(action.payload),
        page: state.page + 1,
      };
    case SEARCH_QUERY:
      let count = 0;
      const selected = state.ppsps.filter(
        (ppsp) =>
          // Select the Ppsps which reference correspond to the value of search
          (ppsp.project_information.reference
            .toLowerCase()
            .includes(action.search.toLowerCase()) ||
            // Select the Ppsps which user first name correspond to the value of search
            ppsp.user.first_name
              .toLowerCase()
              .includes(action.search.toLowerCase()) ||
            // Select the Ppsps which user last name correspond to the value of search
            ppsp.user.last_name
              .toLowerCase()
              .includes(action.search.toLowerCase())) &&
          // Limit the result to 12 max
          count++ < 12
      );
      return {
        ...state,
        // Reinitialize the infinite scroll when use the search bar
        page: 2,
        search: action.search,
        selectedPpsps: selected,
      };
    default:
      return state;
  }
};

export default reducerPpsps;
