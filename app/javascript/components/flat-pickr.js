import flatpickr from 'flatpickr';
import 'flatpickr/dist/themes/material_orange.css';
import { French } from 'flatpickr/dist/l10n/fr';
import rangePlugin from 'flatpickr/dist/plugins/rangePlugin';

const flatPickerDate = () => {
  flatpickr('#range_start', {
    // eslint-disable-next-line new-cap
    plugins: [new rangePlugin({ input: '#range_end' })],
    disableMobile: 'true',
    locale: French,
    allowInput: document.body.dataset.markerEnv === 'test' ? 'true' : 'false',
  });
};

const flatPickerSummerTime = () => {
  flatpickr('#time_summer_start', {
    disableMobile: 'true',
    enableTime: true,
    noCalendar: true,
    dateFormat: "H:i",
    time_24hr: true,
    locale: French,
  });
  flatpickr('#time_summer_end', {
    disableMobile: 'true',
    enableTime: true,
    noCalendar: true,
    dateFormat: "H:i",
    time_24hr: true,
    locale: French,   
  });
  flatpickr('#time_summer_start_friday', {
    disableMobile: 'true',
    enableTime: true,
    noCalendar: true,
    dateFormat: "H:i",
    time_24hr: true,
    locale: French,
  });
  flatpickr('#time_summer_end_friday', {
    disableMobile: 'true',
    enableTime: true,
    noCalendar: true,
    dateFormat: "H:i",
    time_24hr: true,
    locale: French,
  });
}

const flatPickerWinterTime = () => {
  flatpickr('#time_winter_start', {
    disableMobile: 'true',
    enableTime: true,
    noCalendar: true,
    dateFormat: "H:i",
    time_24hr: true,
    locale: French,
  });
  flatpickr('#time_winter_end', {
    disableMobile: 'true',
    enableTime: true,
    noCalendar: true,
    dateFormat: "H:i",
    time_24hr: true,
    locale: French,
  });
  flatpickr('#time_winter_start_friday', {
    disableMobile: 'true',
    enableTime: true,
    noCalendar: true,
    dateFormat: "H:i",
    time_24hr: true,
    locale: French,
  });
  flatpickr('#time_winter_end_friday', {
    disableMobile: 'true',
    enableTime: true,
    noCalendar: true,
    dateFormat: "H:i",
    time_24hr: true,
    locale: French,
  });
}

export { flatPickerDate,  flatPickerSummerTime, flatPickerWinterTime};
