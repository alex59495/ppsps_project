import mapboxgl from 'mapbox-gl';
import MapboxWorker from 'worker-loader!mapbox-gl/dist/mapbox-gl-csp-worker';

mapboxgl.workerClass = MapboxWorker;

const initMapbox = async () => {
  const res = await fetch("https://api.mapbox.com/styles/v1/mapbox/streets-v11/static/geojson(%7B%22type%22%3A%22Point%22%2C%22coordinates%22%3A%5B-73.99%2C40.7%5D%7D)/-73.99,40.70,1/500x300?access_token=pk.eyJ1IjoibWF4ZW5jZWxlbm9pciIsImEiOiJja2RhNG9iMG8wZXY2MnptaDUzeDhidThpIn0.uNEuinv9hVcuU9VvtlOOsg")
  console.log(res)
  const mapElement = document.getElementById('map');

  // const fitMapToMarkers = (map, marker) => {
  //   const bounds = new mapboxgl.LngLatBounds();
  //   bounds.extend([ marker.lng, marker.lat ]);
  //   map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 });
  // };

  // if (mapElement) { // only build a map if there's a div#map to inject into
  //   mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
  //   const map = new mapboxgl.Map({
  //     container: 'map',
  //     style: 'mapbox://styles/mapbox/streets-v10'
  //   });
  //   const marker = JSON.parse(mapElement.dataset.marker);
  //     new mapboxgl.Marker()
  //       .setLngLat([ marker.lng, marker.lat ])
  //       .addTo(map);
  //   fitMapToMarkers(map, marker);
  // }
};

export { initMapbox };