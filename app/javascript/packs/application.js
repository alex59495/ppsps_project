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
import reactPpsp from '../components/react-ppsp/index';
import reactFromConductors from '../components/form-conductors/index';
import reactFormRisks from '../components/form-risks/index';
import reactFormAltitudeWorks from '../components/form-altitude-works/index';
import reactFormSiteInstallations from '../components/form-site-installations/index';
import reactFormLifesaver from '../components/form-lifesavers/index';

// import { AutoCompleteGeocoding } from "../components/autocomplete"
// La clé API pour l'utilisation de l'autocomplete Geocoding se trouve dans config/application.yml
import { flatPickerDate, flatPickerSummerTime, flatPickerWinterTime } from '../components/flat-pickr';
import select2 from '../components/select-2';
import infiniteScroll from '../components/infinite-scroll-db';
import { popUp } from '../components/popup';
import calendar from '../components/calendar';
import error from '../components/errors';
import navbarDropdown from '../components/navbar-dropdown';
import sweetAlertMail from '../components/sweetAlert';
import InitializeTinyMce from '../components/tinymce-editor';
import { initMapbox } from '../components/mapbox';
import { logoClient, logoCompany } from '../components/displayLogo';
import { hideSecurityKit, hidePlanInstallation, hideTimetableSummer, hideTimetableWinter, hideTinyMce, hideInfirmary } from '../components/hide-elements'
import animateSubmitPpsps from '../components/animateSubmitPpsps'

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
  InitializeTinyMce();
  hideTinyMce();
  navbarDropdown();
  error();
  select2();
  flatPickerDate();
  flatPickerSummerTime();
  flatPickerWinterTime();
  infiniteScroll();
  hideInfirmary();
  popUp();
  calendar();
  sweetAlertMail();
  logoClient();
  logoCompany();
  hideSecurityKit();
  hidePlanInstallation();
  hideTimetableWinter();
  hideTimetableSummer();
  animateSubmitPpsps();

  // Permet de pouvoir appeler la function dans mon JS.erb
  window.hideSecurityKit = hideSecurityKit;

  // React
  reactFromConductors();
  reactPpsp();
  reactFormRisks();
  reactFormAltitudeWorks();
  reactFormSiteInstallations();
  reactFormLifesaver();

  // initMapbox(); Pas nécessaire pour le moment
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
