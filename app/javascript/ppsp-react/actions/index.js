export const FETCH_PPSPS = 'FETCH_PPSPS'


export const fetchPpsps = () => {
  const promise = fetch('api/v1/ppsps')
    .then(response => response.json());
  return {
    type: FETCH_PPSPS,
    payload: promise,
  };
}