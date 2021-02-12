const logoClient = () => {
  const inputLogoClient = document.getElementById('ppsp_logo_client');
  const btnDestroyLogo = document.getElementById('btn-destroy-logo');

  if (btnDestroyLogo) {
    btnDestroyLogo.addEventListener('click', () => {
      inputLogoClient.disabled = false;
    });
  }
  // eslint-disable-next-line consistent-return
  const loadLogoClient = (event) => {
    const image = document.getElementById('newLogo');
    const oldLogo = document.getElementById('oldLogo');
    const btnCancelUpload = document.getElementById('removeUpload');
    const formatAccepted = ["image/jpeg", "image/jpg", "image/png"];
    const errorFormat = document.getElementById('error-format')
    // Si il exite un fichier à uploader
    if (event.target.files[0] && formatAccepted.includes(event.target.files[0].type)) {
      btnCancelUpload.style.display = 'block';
      errorFormat.innerText = '';
      // Si il existe un ancien logo client
      if (oldLogo) {
        oldLogo.style.display = 'none';
      }
      btnCancelUpload.addEventListener('click', () => {
        // Si il exite un fichier à uploader
        // eslint-disable-next-line no-param-reassign
        event.target.value = null;
        btnCancelUpload.style.display = 'none';
        loadLogoClient(event);
      });
      image.style.display = 'block';
      // eslint-disable-next-line no-return-assign
      return (image.src = URL.createObjectURL(event.target.files[0]));
    }  
    // Si l'input existe mais est au mauvais format
    else if (event.target.files[0]) {
      event.target.value = null;
      errorFormat.innerText = "Le format et/ou la taille de l'image n'est pas valide"
    };
    image.style.display = 'none';
    if (oldLogo) {
      oldLogo.style.display = 'block';
    }
  };

  if (inputLogoClient) {
    inputLogoClient.addEventListener('change', loadLogoClient);
  }
};

const logoCompany = () => {
  const inputCompanyLogo = document.getElementById('company_logo');
  
  const loadLogoCompany = (event) => {
    const editCompany = document.querySelector('.edit_company')
    if(editCompany) {
      const image = document.getElementById('newLogo');
      const arrow = document.querySelector('.fa-long-arrow-alt-right');
      const btnCancelUpload = document.getElementById('removeUpload');
      const btnDeleteLogo = document.getElementById('removeLogo');
      // Si il exite un fichier à uploader
      if(event.target.files[0]) {
        arrow.style.display = 'block';
        btnCancelUpload.style.display = 'block'
        // Si l'entreprise n'a pas encore de logo le bouton n'existe pas
        if(btnDeleteLogo) {
          btnDeleteLogo.style.display = 'none'
        }
        btnCancelUpload.addEventListener('click', (e) => {
          // Si il exite un fichier à uploader
          event.target.value = null
          btnCancelUpload.style.display = 'none'
          loadLogo(event)
        })
        image.style.display = 'block';
        return image.src = URL.createObjectURL(event.target.files[0]);
      } {
        arrow.style.display = 'none';
        image.style.display = 'none';
        // Si l'entreprise n'a pas encore de logo le bouton n'existe pas
        if(btnDeleteLogo) {
          btnDeleteLogo.style.display = 'block'
        }
      }
    }
  };

  if (inputCompanyLogo) {
    inputCompanyLogo.addEventListener('change', loadLogoCompany);
  }
}

export { logoClient, logoCompany };
