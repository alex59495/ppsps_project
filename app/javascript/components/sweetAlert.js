import Swal from 'sweetalert2';

const sweetAlertMail = () => {
  if (document.getElementById('message-sent')) {
    Swal.fire({
      icon: 'success',
      title: 'Message envoyé',
      text:
        'Merci de votre sollicitation./n Nous revenons vers vous très bientôt.',
    });
  } else if (document.getElementById('message-not-sent')) {
    Swal.fire({
      icon: 'error',
      title: "Problème lors de l'envoi",
      text:
        "Une erreur est survenue empêchant l'envoi de l'email. Merci de réessayer plus tard/n Désolé pour le désagrément",
    });
  }
};

export default sweetAlertMail;
