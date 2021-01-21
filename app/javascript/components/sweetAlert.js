import Swal from 'sweetalert2';

const initSweetAlert = (selector, options = {}) => {
  const modal = document.getElementById(selector);
  if (modal) {
    Swal.fire(options);
  }
};

const sweetAlertMail = () => {
  initSweetAlert('message-sent', {
    icon: 'success',
    title: 'Message envoyé',
    text: 'Merci de votre sollicitation. Nous revenons vers vous très bientôt.',
  });
};

export default sweetAlertMail;
