const hideSecurityKit = () => {
  if(document.querySelector('form.edit_company')) {
    const btnAdd = document.getElementById('btn-add-security-kit');
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

export { hideSecurityKit, hidePlanInstallation, hideTimetableSummer, hideTimetableWinter }