export const FETCH_PPSPS = 'FETCH_PPSPS';
export const SEARCH_QUERY = 'SEARCH_QUERY';
export const LOAD_MORE = 'LOAD_MORE';
export const LOADING_TRUE = 'LOADING_TRUE';

import axios from 'axios';

export const fetchPpsps = async (showUser) => {
  const response = await axios({
    method: 'get',
    url: `/api/v1/ppsps?show_user=${showUser}`
  });
  // const promise = response.json();
  return {
    type: FETCH_PPSPS,
    payload: response.data,
  };
};

export const loadingTrue = () => ({
  type: LOADING_TRUE,
  payload: true,
});

export const loadMore = async (showUser, page, search) => {
  const response = await axios(`/api/v1/ppsps?show_user=${showUser}&page=${page}&search=${search}`);
  // const promise = response.json();
  return {
    type: LOAD_MORE,
    payload: response.data,
  };
};

export const searchPpsp = (query) => ({
  type: SEARCH_QUERY,
  payload: query,
});
