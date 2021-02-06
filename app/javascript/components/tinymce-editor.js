const ShowCompanySecuContent = () => {
  const containerTiny = document.querySelector('.tinymce');
  const editFormPpsp = document.querySelector('.edit_ppsp');
  const newFormPpsp = document.querySelector('.new_ppsp');
  const editCompany = document.querySelector('.edit_company')
  if (containerTiny && (editFormPpsp || newFormPpsp)) {
    const ppspSecuContent = containerTiny.dataset.ppsp_secu;
    // Si pas de content enregistré pour le PPSPS on renvoit celui de l'entreprise
    if (ppspSecuContent === 'false') {
      const text = containerTiny.dataset.company_secu;
      tinymce.activeEditor.setContent(text);
    }
  } else if (editCompany) {
    tinymce.activeEditor.setContent(document.getElementById('company_content_secu').value);
  }
};

const InitializeTinyMce = async () => {
  tinymce.remove();
  await tinymce.init({
    selector: '.tinymce',
    setup(editor) {
      editor.on('init', () => {
        editor.setContent('');
      });
    },
    plugins: ['image imagetools', 'paste'],
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
  });
  await ShowCompanySecuContent();
};

export default InitializeTinyMce;
