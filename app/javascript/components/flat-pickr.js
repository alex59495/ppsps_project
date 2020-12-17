import flatpickr from 'flatpickr';
import 'flatpickr/dist/themes/material_orange.css';
import { French } from 'flatpickr/dist/l10n/fr';

const flatPicker = () => {
  flatpickr('.datepicker', {
    altInput: true,
    locale: French,
  });
};

export default flatPicker;
