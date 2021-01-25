const trixEditor = () => {
  const trix = document.querySelector('trix-editor');
  const editFormPpsp = document.querySelector('.edit_ppsp');
  const newFormPpsp = document.querySelector('.new_ppsp');
  if (trix && (editFormPpsp || newFormPpsp)) {
    trix.insertAdjacentHTML('beforeend', trix.dataset.content_secu);
  }
};

export default trixEditor;
