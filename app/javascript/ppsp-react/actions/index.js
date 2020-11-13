export const FETCH_PPSPS = 'FETCH_PPSPS'
export const SEARCH_QUERY = 'SEARCH_QUERY'
export const FETCH_USER_PPSPS = 'SEARCH_QUERY'


export const fetchPpsps = (showUser) => {
  const show_user = showUser
  const promise = fetch(`/api/v1/ppsps?show_user=${show_user}`)
    .then(response => response.json())
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