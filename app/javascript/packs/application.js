// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

//= require jquery
//= require rails-ujs
//= require turbolinks
//= require_tree .

import 'bootstrap';
import ReactDOM from 'react-dom';

// Import react elements
// import '../react-ppsp/index'
import reactPpsp from '../components/react-ppsp/index';

// import { AutoCompleteGeocoding } from "../components/autocomplete"
// La clé API pour l'utilisation de l'autocomplete Geocoding se trouve dans config/application.yml
import { cardForm } from '../components/card-form';
import flatPicker from '../components/flat-pickr';
import select2 from '../components/select-2';
import infiniteScroll from '../components/infinite-scroll-db';
import { popUp } from '../components/popup';
import calendar from '../components/calendar';
import error from '../components/errors';
import navbarDropdown from '../components/navbar-dropdown';
import sweetAlertMail from '../components/sweetAlert';
import InitializeTinyMce from '../components/tinymce-editor';
import { initMapbox } from '../components/mapbox';
import logoClient from '../components/displayLogoClient';

require('@rails/ujs').start();
require('turbolinks').start();
require('@rails/activestorage').start();
require('../channels');

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

document.addEventListener('turbolinks:load', () => {
  // Have to add those two lines in order to force the rerender of tinyMCE with turbolinks
  InitializeTinyMce();
  navbarDropdown();
  error();
  select2();
  flatPicker();
  cardForm();
  reactPpsp();
  infiniteScroll();
  popUp();
  calendar();
  sweetAlertMail();
  // initMapbox(); Pas nécessaire pour le moment
  logoClient();
});
// Support component names relative to this directory:
const componentRequireContext = require.context('components', true);
const ReactRailsUJS = require('react_ujs');

ReactRailsUJS.useContext(componentRequireContext);
ReactRailsUJS.handleEvent('turbolinks:before-render', () => {
  if (document.getElementById('ppsps-react')) {
    ReactDOM.unmountComponentAtNode(document.getElementById('ppsps-react'));
  }
});
