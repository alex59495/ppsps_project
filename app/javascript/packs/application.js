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
import reactFormMachines from '../components/machines-form/index';
import FormSubcontractors from '../components/form-subcontractors/index';
import FormRisks from '../components/form-risks/index';
import FormAltitudeWorks from '../components/form-altitude-work/index';
import FormSiteInstallations from '../components/form-site-installation/index';

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
  InitializeTinyMce();
  navbarDropdown();
  error();
  select2();
  flatPicker();
  cardForm();
  infiniteScroll();
  popUp();
  calendar();
  sweetAlertMail();
  logoClient();

  // React
  reactFormMachines();
  reactPpsp();
  FormSubcontractors();
  FormRisks();
  FormAltitudeWorks();
  FormSiteInstallations();

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
  if (document.getElementById('react-render-subcontractors')) {
    ReactDOM.unmountComponentAtNode(
      document.getElementById('react-render-subcontractors')
    );
  }
});
