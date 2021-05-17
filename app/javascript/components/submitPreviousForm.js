const submitPreviousForm = () => {
  const form = document.getElementById('ppsp_form')
  if (form) {
    const linkPrevious = document.getElementById('link-previous')
    if (linkPrevious) {
      linkPrevious.addEventListener('click', (e) => {
        e.preventDefault()
        form.insertAdjacentHTML('afterbegin', `<input type='hidden' name='back' value=${true} />`)
        form.submit()
      })
    }
    const linkTerminate = document.getElementById('SubmitPpspsFormBtn')
    if (linkTerminate) {
      linkTerminate.addEventListener('click', (e) => {
        e.preventDefault()
        form.insertAdjacentHTML('afterbegin', `<input type='hidden' name='end' value=${true} />`)
        form.submit()
      })
    }
  }
}

export { submitPreviousForm }