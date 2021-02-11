const animateSubmitPpsps = () => {
  const btnSubmit = document.getElementById('SubmitPpspsFormBtn')
  btnSubmit.addEventListener('click', () => {
    document.querySelector('#myModal').style.display = 'block'
    document.querySelector('#myModal').classList.add('modal-background')
  })
}

export default animateSubmitPpsps