const hideSecurityKit = () => {
  if(document.querySelector('form.edit_user')) {
    const btnAdd = document.querySelector('.btn-add-security-kit');
    const formAdd = document.querySelector('#add-security-kit');
    btnAdd.addEventListener('click', () => {
      formAdd.classList.toggle('hidden');
      btnAdd.innerText = btnAdd.innerText === 'Ajouter' ? 'Cacher' : 'Ajouter';
    })
  }

}

export default hideSecurityKit