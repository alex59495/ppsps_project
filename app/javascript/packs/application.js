// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

//= require jquery
//= require rails-ujs
//= require turbolinks
//= require_tree .
require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
import "bootstrap";

// Import react elements
// import '../react-ppsp/index'
import { reactPpsp } from '../react-ppsp/index';

// import { AutoCompleteGeocoding } from "../components/autocomplete"
// La clé API pour l'utilisation de l'autocomplete Geocoding se trouve dans config/application.yml
import { hideForm } from "../components/hide-form";
import { cardForm } from "../components/card-form";

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

document.addEventListener('turbolinks:load', () => {
  hideForm();
  cardForm();
  reactPpsp()
})
// Support component names relative to this directory:
var componentRequireContext = require.context("components", true);
var ReactRailsUJS = require("react_ujs");
ReactRailsUJS.useContext(componentRequireContext);
