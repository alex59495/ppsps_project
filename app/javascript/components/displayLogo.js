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

export { logoCompany };
