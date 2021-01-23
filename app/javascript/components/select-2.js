import $ from 'jquery';
import 'select2';
import 'select2/dist/css/select2.css';

$.fn.select2.amd.define(
  'select2/i18n/fr',
  [],
  require('select2/src/js/select2/i18n/fr')
);

const select2 = () => {
  if ($('.select-2')) {
    $('.select-2').select2({
      language: 'fr',
    });
  }
};

export default select2;
