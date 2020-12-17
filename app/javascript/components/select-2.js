import $ from 'jquery';
import 'select2';
import 'select2/dist/css/select2.css';

const select2 = () => {
  if ($('.select-2')) {
    $('.select-2').select2();
  }
};

export default select2;
