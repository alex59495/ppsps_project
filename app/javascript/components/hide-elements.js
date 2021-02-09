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

const hidePlanInstallation = () => {
  const inputPlan = document.getElementById('ppsp_worksite_attributes_plan')
  const alertText =document.getElementById('alert-text-plan')
  if(inputPlan) {
    if(inputPlan.checked === true) {
      alertText.classList.remove('hidden-visibility')
    }
    inputPlan.addEventListener('click', () => {
      alertText.classList.toggle('hidden-visibility')
    })
  }
}

export { hideSecurityKit, hidePlanInstallation }