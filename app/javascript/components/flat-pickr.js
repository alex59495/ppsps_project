import flatpickr from 'flatpickr';
import 'flatpickr/dist/themes/material_orange.css';
import { French } from 'flatpickr/dist/l10n/fr';
import rangePlugin from 'flatpickr/dist/plugins/rangePlugin';

const flatPicker = () => {
  flatpickr('#range_start', {
    // eslint-disable-next-line new-cap
    plugins: [new rangePlugin({ input: '#range_end' })],
    disableMobile: 'true',
    locale: French,
    allowInput: document.body.dataset.markerEnv === 'test' ? 'true' : 'false',
  });
};

export default flatPicker;
