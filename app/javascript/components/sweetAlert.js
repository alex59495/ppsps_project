import Swal from 'sweetalert2';

const sweetAlertMail = () => {
  if (document.getElementById('message-sent')) {
    Swal.fire({
      icon: 'success',
      title: 'Message envoyé',
      html:
        'Merci de votre sollicitaiton.</br>Nous revenous vers vous très prochainement.',
    });
  } else if (document.getElementById('message-not-sent')) {
    Swal.fire({
      icon: 'error',
      title: "Problème lors de l'envoi",
      html:
        "Une erreur est survenue empêchant l'envoi de l'email. Merci de réessayer plus tard.</br> Désolé pour le désagrément",
    });
  }
};

export default sweetAlertMail;
