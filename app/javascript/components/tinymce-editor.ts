import tinymce from 'tinymce'

const ShowSecuContent = () => {
  const containerTiny : HTMLElement = document.querySelector('.tinymce');
  const editFormPpsp : HTMLElement = document.querySelector('.edit_ppsp');
  const newFormPpsp : HTMLElement = document.querySelector('.new_ppsp');
  const editCompany : HTMLElement = document.querySelector('.edit_company')
  if (containerTiny && (editFormPpsp || newFormPpsp)) {
    const ppspSecuContent = containerTiny.dataset.ppsp_secu;
    // Si on est sur la page du form du PPSP on révupère le contenu du content_secu du PPSP
    tinymce.activeEditor.setContent(ppspSecuContent)
  } else if (containerTiny && editCompany) {
    const companySecuContent = containerTiny.dataset.company_secu;
    // Si on est sur la page de l'entreprise on révupère le contenu du content_secu de l'entreprise
    tinymce.activeEditor.setContent(companySecuContent);
  }
};

const InitializeTinyMce = async () => {
const containerTiny : HTMLElement = document.querySelector('.tinymce');
  if(containerTiny) {
    tinymce.remove();
    await tinymce.init({
      selector: '.tinymce',
      setup(editor) {
        editor.on('init', () => {
          editor.setContent('');
        });
      },
      plugins: [
        'image imagetools', 'paste',
        "advlist autolink lists link image charmap print preview hr anchor pagebreak",
        "searchreplace wordcount visualblocks visualchars code fullscreen",
        "insertdatetime media nonbreaking save table contextmenu directionality",
        "emoticons template paste textcolor colorpicker textpattern"
      ],
      external_plugins: {
        "paste-it-cleaned-tiny":
          "https://cdn.pasteitapi.com/v1/pasteitcleaned.min.js?apiKey=KpAmpiNAMsXzZjQUZJHA"
      },
      toolbar1: "insertfile undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image",
      height: 600,
      image_advtab: true,
      // We can copy/paste images from desktop
      paste_data_images: true,
      // Add a button to search images from the desktop
      file_picker_callback: function(callback, value, meta) {
        if (meta.filetype == 'image') {
          $('#upload').trigger('click');
          $('#upload').on('change', function() {
            var file = (<HTMLInputElement>this).files[0];
            var reader = new FileReader();
            reader.onload = function(e) {
              callback(e.target.result, {
                alt: ''
              });
            };
            reader.readAsDataURL(file);
          });
        }
      },
    });
    ShowSecuContent();
  }
};

export default InitializeTinyMce;
