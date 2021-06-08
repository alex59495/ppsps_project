const logoCompany = () : void => {
  const inputCompanyLogo : HTMLElement = document.getElementById('company_logo');
  
  const loadLogoCompany = (event) : void | string => {
    const editCompany : HTMLElement  = document.querySelector('.edit_company')
    if(editCompany) {
      const image : HTMLImageElement  = document.querySelector('#newLogo');
      const arrow : HTMLElement  = document.querySelector('.fa-long-arrow-alt-right');
      const btnCancelUpload : HTMLElement  = document.getElementById('removeUpload');
      const btnDeleteLogo : HTMLElement  = document.getElementById('removeLogo');
      // Si il exite un fichier à uploader
      if((<HTMLInputElement>event.target).files[0]) {
        arrow.style.display = 'block';
        btnCancelUpload.style.display = 'block'
        // Si l'entreprise n'a pas encore de logo le bouton n'existe pas
        if(btnDeleteLogo) {
          btnDeleteLogo.style.display = 'none'
        }
        btnCancelUpload.addEventListener('click', (e) => {
          // Si il exite un fichier à uploader
          (<HTMLInputElement>e.target).value = null
          btnCancelUpload.style.display = 'none'
          loadLogoCompany(e)
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
