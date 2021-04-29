const animateSubmitPpsps = () => {
  const btnSubmit = document.getElementById('SubmitPpspsFormBtn')
  if(btnSubmit) {
    btnSubmit.addEventListener('click', () => {
      document.querySelector('#myModal').style.display = 'block'
      document.querySelector('#myModal').classList.add('modal-background')
    })
  }
}


export {animateSubmitPpsps}