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
  const inputPlan = document.getElementById('ppsp_plan')
  const alertText = document.getElementById('alert-text-plan')
  if(inputPlan) {
    inputPlan.addEventListener('click', () => {
      alertText.classList.toggle('hidden-visibility')
    })
  }
}

const hideTimetableSummer = () => {
  const inputSummer = document.getElementById('ppsp_timetable_summer');
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
  const inputWinter = document.getElementById('ppsp_timetable_winter');
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

const hideInfirmary = () => {
  const btnInfirmary = document.getElementById('infirmary');
  const infirmaryText = document.getElementById('infirmary-text');
  const InputInfirmaryText = document.getElementById('ppsp_worksite_attributes_infirmary_text');
  if(btnInfirmary) {
    btnInfirmary.addEventListener('click', (e) => {
      infirmaryText.classList.toggle('hidden');
      // Clean the input if it is hidden
      if(infirmaryText.classList.contains('hidden')) {
        InputInfirmaryText.value = ''
      }
    })
  }
}

export { hideSecurityKit, hidePlanInstallation, hideTimetableSummer, hideTimetableWinter, hideInfirmary }