export const FETCH_PPSPS = 'FETCH_PPSPS'
export const SEARCH_QUERY = 'SEARCH_QUERY'
export const LOAD_MORE = 'LOAD_MORE'


export const fetchPpsps = (showUser) => {
  const promise = fetch(`/api/v1/ppsps?show_user=${showUser}`)
    .then(response => response.json())
  return {
    type: FETCH_PPSPS,
    payload: promise,
  };
}

export const loadMore = (showUser, page) => {
  const promise = fetch(`/api/v1/ppsps?show_user=${showUser}&page=${page}`)
    .then(response => response.json())
  return {
    type: LOAD_MORE,
    payload: promise,
  };
}

export const searchPpsp = (query) => {
  return {
    type: SEARCH_QUERY,
    search: query
  };
}