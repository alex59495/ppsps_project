const animateSubmitPpsps = () : void => {
  const btnSubmit : HTMLElement = document.getElementById('SubmitPpspsFormBtn')
  if(btnSubmit) {
    btnSubmit.addEventListener('click', () => {
      const myModal : HTMLElement = document.querySelector('#myModal')
      myModal.style.display = 'block'
      myModal.classList.add('modal-background')
    })
  }
}


export {animateSubmitPpsps}