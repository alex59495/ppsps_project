const popUp = () => {
  document.querySelectorAll('.infos-popup').forEach((pop, index) => {
    if(index == 0) {
      const text = "<div class='pop-up' id='pop-direcct'>Directions régionales des entreprises, de la concurrence, de la consommation, du travail et de l'emploi</div>"
      pop.addEventListener('mouseover', () => {
        pop.insertAdjacentHTML('beforebegin', text)
      })
      pop.addEventListener('mouseleave', () => {
        document.getElementById('pop-direcct').remove()
      })
    }
    if(index == 1 ) {
      const text = "<div class='pop-up' id='pop-oppbtp'>Organisme Professionnel de Prévention du Bâtiment et des Travaux Publics</div>"
      pop.addEventListener('mouseover', () => {
        pop.insertAdjacentHTML('beforebegin', text)
      })
      pop.addEventListener('mouseleave', () => {
        document.getElementById('pop-oppbtp').remove()
      })
    }
  })
}

export { popUp }