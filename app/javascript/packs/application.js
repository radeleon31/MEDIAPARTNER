// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

// agregado por JH
require("chartkick")
require("chart.js")
//= require chartkick
//= require bootstrap/bootstrap-tooltip
//= require active_storage_drag_and_drop




// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)


// ----------------------------------------------------
// Note(lewagon): ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE YOUR OWN JS STARTING FROM HERE 👇
// ----------------------------------------------------

// External imports
import "bootstrap";

import { initFlatpickr } from "../plugins/flatpickr";
// Internal imports, e.g:
import { openSearchBarOnClick } from '../components/search-bar';
// import { showingMetrics } from '../components/overview-metrics';
import { toggleNavbar } from '../components/navbar';

document.addEventListener('turbolinks:load', () => {
  // Call your functions here, e.g:
  openSearchBarOnClick();
 
  toggleNavbar();
  
  initFlatpickr();

  Chartkick.eachChart( function(chart) {
    chart.redraw();
  });

});



