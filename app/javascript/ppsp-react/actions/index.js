export const FETCH_PPSPS = 'FETCH_PPSPS'
export const SEARCH_QUERY = 'SEARCH_QUERY'


export const fetchPpsps = () => {
  const promise = fetch('api/v1/ppsps')
    .then(response => response.json());
  return {
    type: FETCH_PPSPS,
    payload: promise,
  };
}

export const searchPpsp = (query) => {
  return {
    type: SEARCH_QUERY,
    search: query
  };
}