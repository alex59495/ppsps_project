import Dropzone from 'dropzone';
import { Controller } from 'stimulus';
import { DirectUpload } from '@rails/activestorage';
import {
  getMetaValue,
  toArray,
  findElement,
  removeElement,
  insertAfter
} from 'helpers';

export default class extends Controller {
  static targets = ['input'];

  connect() {
    this.dropZone = createDropZone(this);
    this.hideFileInput();
    this.bindEvents();
    Dropzone.autoDiscover = false;
  }

  hideFileInput() {
    this.inputTarget.disabled = true;
    this.inputTarget.style.display = 'none';
  }

  bindEvents() {
    this.dropZone.on('addedfile', file => {
      setTimeout(() => {
        file.accepted && createDirectUploadController(this, file).start();
      });
    });

    this.dropZone.on('removedfile', file => {
      const hiddenInput = file.controller.hiddenInput
      file.controller && removeElement(hiddenInput);
    });

    this.dropZone.on('canceled', file => {
      file.controller && file.controller.xhr.abort();
    });
  }

  get headers() {
    return { 'X-CSRF-Token': getMetaValue('csrf-token') };
  }

  get url() {
    return this.inputTarget.getAttribute('data-direct-upload-url')
  }

  get maxFiles() {
    return this.data.get('maxFiles') || 5;
  }

  get maxFileSize() {
    return this.data.get('maxFileSize') || 256;
  }

  get acceptedFiles() {
    return this.data.get('acceptedFiles');
  }

  get addRemoveLinks() {
    return this.data.get('addRemoveLinks') || true;
  }
}

class DirectUploadController {
  constructor(source, file) {
    this.directUpload = createDirectUpload(file, source.url, this);
    this.source = source;
    this.file = file;
  }

  start() {
    this.file.controller = this;
    this.hiddenInput = this.createHiddenInput();
    this.directUpload.create((error, attributes) => {
      if(error) {
        removeElement(this.hiddenInput);
        this.emitDropzoneError(error);
      } else {
        this.hiddenInput.value = attributes.signed_id;
        this.emitDropzoneSuccess();
      }
    })
  }

  createHiddenInput() {
    const input = document.createElement('input');
    input.type = 'hidden';
    input.name = this.source.inputTarget.name;
    insertAfter(input, this.source.inputTarget);
    return input;
  }

  directUploadWillStoreFileWithXHR(xhr) {
    this.bindProgressiveEvent(xhr);
    this.emitDropzoneUpLoading();
  }

  bindProgressiveEvent(xhr) {
    this.xhr = xhr;
    this.xhr.upload.addEventListener('upload', event => {
      this.uploadRequestDidProgress(event);
    })
  }

  uploadRequestDidProgress(event) {
    const element = this.source.element;
    const progress = (event.loaded / event.total) * 100;
    findElement(
      this.file.previewTemplate,
      '.dz-upload'
    ).style.width = `${progress}`
  }

  emitDropzoneUpLoading() {
    this.file.status = Dropzone.UPLOADING;
    this.source.dropZone.emit('processing', this.file);

    // // Disable submit button
    document.getElementById('SubmitPpspsFormBtn').disabled = true;
    document.getElementById('SubmitPpspsFormBtn').innerText = 'Téléchargement en cours';
  }

  emitDropzoneError(error) {
    this.file.status = Dropzone.ERROR;
    this.source.dropZone.emit('error', this.file, error);
    this.source.dropZone.emit('complete', this.file);
  }

  emitDropzoneSuccess() {
    this.file.status = Dropzone.SUCCESS;
    this.source.dropZone.emit('success', this.file);
    this.source.dropZone.emit('complete', this.file);

    // Add an attribute to the public storage
    const active_record_key_id = (JSON.parse(this.file.controller.xhr.response)['public_id'])
    this.hiddenInput.setAttribute('data-publicid', active_record_key_id)

    // // Disable submit button
    document.getElementById('SubmitPpspsFormBtn').disabled = false;
    document.getElementById('SubmitPpspsFormBtn').innerText = 'Valider';
  }
}

function createDirectUploadController(source, file) {
  return new DirectUploadController(source, file);
}

function createDirectUpload(file, url, controller) {
  return new DirectUpload(file, url, controller);
}

function createDropZone(controller) {
  return new Dropzone(controller.element, {
    url: controller.url,
    headers: controller.headers,
    maxFiles: controller.maxFiles,
    maxFileSize: controller.maxFileSize,
    accetedFiles: controller.acceptedFiles,
    addRemoveLinks: controller.addRemoveLinks,
    autoProcessQueue: false
  });
}