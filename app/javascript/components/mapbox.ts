// A CORRIGER SI UN JOUR ON UTILISE MAPBOX AUTRE QUE VIA LE LIEN
import * as mapboxgl from 'mapbox-gl';
import * as MapboxWorker from 'worker-loader!mapbox-gl/dist/mapbox-gl-csp-worker';

mapboxgl.workerClass = MapboxWorker;

interface marker {
  lat: string,
  lng: string
}

const initMapbox = () : void => {
  const mapElement : HTMLElement = document.getElementById('map');

  const fitMapToMarkers = (map, marker : marker) => {
    const bounds = new mapboxgl.LngLatBounds();
    bounds.extend([ marker.lng, marker.lat ]);
    map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 });
  };

  if (mapElement) { // only build a map if there's a div#map to inject into
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    const map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/mapbox/streets-v10'
    });
    const marker = JSON.parse(mapElement.dataset.marker);
      new mapboxgl.Marker()
        .setLngLat([ marker.lng, marker.lat ])
        .addTo(map);
    fitMapToMarkers(map, marker);
  }
};

export { initMapbox };