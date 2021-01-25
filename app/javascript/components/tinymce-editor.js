const ShowCompanySecuContent = () => {
  setTimeout(() => {
    const containerTiny = document.querySelector('.tinymce');
    const editFormPpsp = document.querySelector('.edit_ppsp');
    const newFormPpsp = document.querySelector('.new_ppsp');
    if (containerTiny && (editFormPpsp || newFormPpsp)) {
      const ppspSecuContent = containerTiny.dataset.ppsp_secu;
      if (ppspSecuContent == 'false') {
        const text = containerTiny.dataset.company_secu;
        tinymce.activeEditor.setContent(text);
      }
    }
  }, 1000);
};

export default ShowCompanySecuContent;
