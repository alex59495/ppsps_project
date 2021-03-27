import axios from 'axios';

export function getMetaValue(name) {
  const element = findElement(document.head, `meta[name="${name}"]`);
  if(element) {
    return element.getAttribute('content');
  }
}

export function findElement(root, selector) {
  if(typeof root == 'string') {
    selector = root;
    root = document;
  }
  return root.querySelector(selector);
}

export function toArray(value) {
  if (Array.isArray(value)) {
    return value;
  } else if (Array.from) {
    return Array.from(value)
  } else {
    return [].slice.call(value)
  }
}

export function removeElement(el) {
  if (el && el.parentNode) {
    el.parentNode.removeChild(el);
    axios({
      url: `${window.location.protocol}/destroy_annexe/${el.dataset.publicid}`,
      headers: {
        'X-CSRF-Token': getMetaValue('csrf-token')
      },
      method: 'delete'
    })
    .then(response => {
      console.log('OK')
    })
    .catch(error => {
      console.log(error)
    })
  }
}

export function insertAfter(el, referenceNode) {
  return referenceNode.parentNode.insertBefore(el, referenceNode)
}