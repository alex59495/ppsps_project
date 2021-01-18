export const FETCH_PPSPS = 'FETCH_PPSPS';
export const SEARCH_QUERY = 'SEARCH_QUERY';
export const LOAD_MORE = 'LOAD_MORE';
export const LOADING_TRUE = 'LOADING_TRUE';

export const fetchPpsps = async (showUser) => {
  const response = await fetch(`/api/v1/ppsps?show_user=${showUser}`);
  const promise = response.json();
  return {
    type: FETCH_PPSPS,
    payload: promise,
  };
};

export const loadingTrue = () => ({
  type: LOADING_TRUE,
  payload: true,
});

export const loadMore = (showUser, page, search) => {
  const promise = fetch(
    `/api/v1/ppsps?show_user=${showUser}&page=${page}&search=${search}`
  ).then((response) => response.json());
  return {
    type: LOAD_MORE,
    payload: promise,
  };
};

export const searchPpsp = (query) => ({
  type: SEARCH_QUERY,
  payload: query,
});
