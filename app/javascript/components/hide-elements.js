const hideSecurityKit = () => {
  if(document.querySelector('.card-kit-security') && document.querySelector('.edit_company')) {
    const btnAdd = document.getElementById('btn-add-security-kit');
    const formAdd = document.querySelector('#add-security-kit');
    // Add the hide form logic
    btnAdd.addEventListener('click', () => {
      formAdd.classList.toggle('hidden');
    })
    // Add logic to change name of button if the button doesn't have an event yet
    const toggleHideButton = () => {
      btnAdd.innerText = btnAdd.innerText === 'Ajouter' ? 'Cacher' : 'Ajouter';
      btnAdd.classList.add('event')
    }
    if(!btnAdd.classList.contains('event')) {
      btnAdd.addEventListener('click', toggleHideButton)
    }
  }
}

const hidePlanInstallation = () => {
  const inputPlan = document.getElementById('ppsp_worksite_attributes_plan')
  const alertText = document.getElementById('alert-text-plan')
  if(inputPlan) {
    inputPlan.addEventListener('click', () => {
      alertText.classList.toggle('hidden-visibility')
    })
  }
}

const hideTimetableSummer = () => {
  const inputSummer = document.getElementById('ppsp_worksite_attributes_timetable_summer');
  const timetables = document.getElementById('timetable-summer-input')
  if(inputSummer) {
    inputSummer.addEventListener('click', () => {
      timetables.classList.toggle('hidden-visibility')
      if(timetables.classList.contains('hidden-visibility')) {
        timetables.querySelectorAll('input').forEach(input => {
          input.value = ''
        })
      }
    })
  }
}

const hideTimetableWinter = () => {
  const inputWinter = document.getElementById('ppsp_worksite_attributes_timetable_winter');
  const timetables = document.getElementById('timetable-winter-input')
  if(inputWinter) {
    inputWinter.addEventListener('click', () => {
      timetables.classList.toggle('hidden-visibility')
      if(timetables.classList.contains('hidden-visibility')) {
        timetables.querySelectorAll('input').forEach(input => {
          input.value = ''
        })
      }
    })
  }
}

const hideTinyMce = () => {
  const tinyMce = document.getElementById('tinymce-form');
  if(tinyMce) {
    const btnTinyMce = document.getElementById('btn-tinymce-form');
    btnTinyMce.addEventListener('click', (e) => {
      tinyMce.classList.toggle('hidden');
      btnTinyMce.innerText = btnTinyMce.innerText === 'Éditeur de texte' ? 'Cacher' : 'Éditeur de texte'
  
    })
  }
}

const hideInfirmary = () => {
  const btnInfirmary = document.getElementById('infirmary');
  const infirmaryText = document.getElementById('infirmary-text');
  if(btnInfirmary) {
    btnInfirmary.addEventListener('click', (e) => {
      infirmaryText.classList.toggle('hidden');
      // Clean the input if it is hidden
      if(infirmaryText.classList.contains('hidden')) {
        infirmaryText.value = ''
      }
    })
  }
}

export { hideSecurityKit, hidePlanInstallation, hideTimetableSummer, hideTimetableWinter, hideTinyMce, hideInfirmary }