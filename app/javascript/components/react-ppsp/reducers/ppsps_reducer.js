import { SEARCH_QUERY, FETCH_PPSPS, LOAD_MORE, LOADING_TRUE } from '../actions/index';

const reducerPpsps = (state, action) => {
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
        loading: false,
      };
    case SEARCH_QUERY:
      let count = 0;
      const selected = state.ppsps.filter(
        (ppsp) =>
          // Select the Ppsps which reference correspond to the value of search
          (ppsp.project_information.reference
            .toLowerCase()
            .includes(action.payload.toLowerCase()) ||
            // Select the Ppsps which user first name + last_name correspond to the value of search
            ppsp.user.full_name
              .toLowerCase()
              .includes(action.payload.toLowerCase())) &&
          // Limit the result to 12 max
          count++ < 12
      );
      return {
        ...state,
        // Reinitialize the infinite scroll when use the search bar
        page: 2,
        search: action.payload,
        selectedPpsps: selected,
      };
    case LOADING_TRUE:
      if (state.loading === false) {
        return {
          ...state,
          loading: action.payload,
        };
      }
      return state;
    default:
      return state;
  }
};

export default reducerPpsps;
