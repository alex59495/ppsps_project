const ShowCompanySecuContent = () => {
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
};

const InitializeTinyMce = () => {
  tinymce.remove();
  tinymce
    .init({
      selector: '.tinymce',
      plugins: ['image imagetools', 'paste', 'cloudinaryimage'],
      height: 600,
      image_advtab: true,
      // We can copy/paste images from desktop
      paste_data_images: true,
      // Add a button to search images from the desktop
      file_picker_callback(callback, value, meta) {
        if (meta.filetype == 'image') {
          $('#upload').trigger('click');
          $('#upload').on('change', function () {
            const file = this.files[0];
            const reader = new FileReader();
            reader.onload = function (e) {
              callback(e.target.result, {
                alt: '',
              });
            };
            reader.readAsDataURL(file);
          });
        }
      },
    })
    .then(() => ShowCompanySecuContent());
};

export default InitializeTinyMce;
