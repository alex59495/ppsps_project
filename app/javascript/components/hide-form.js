const HideForm = () => {
  if (document.getElementById('siteInstallation')) {
    const siteInstallation = document.getElementById('siteInstallation');
    const checkSiteInstallation = document.getElementById('checkSiteInstallation');
    checkSiteInstallation.addEventListener('click', (event) => {
      siteInstallation.classList.toggle('hidden');
    })
  }
  if (document.getElementById('altitudeWork')) {
    const altitudeWork = document.getElementById('altitudeWork');
    const checkAltitudeWork = document.getElementById('checkAltitudeWork');
    checkAltitudeWork.addEventListener('click', (event) => {
      altitudeWork.classList.toggle('hidden');
    })
  }
}

export { HideForm }