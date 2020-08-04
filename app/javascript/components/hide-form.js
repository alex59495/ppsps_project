const HideForm = () => {
  if (document.getElementById('siteInstallationType')) {
    const siteInstallationType = document.getElementById('siteInstallationType');
    const checkSiteInstallation = document.getElementById('checkSiteInstallation');
    checkSiteInstallation.addEventListener('click', (event) => {
      siteInstallationType.classList.toggle('hidden');
    })
    const checkSiteInstallationMobile = document.getElementById('checkSiteInstallationMobile');
    const siteInstallationMobile = document.getElementById('siteInstallationMobile');
    checkSiteInstallationMobile.addEventListener('click', (event) => {
      siteInstallationMobile.classList.toggle('hidden');
    })
    const checkSiteInstallationFix = document.getElementById('checkSiteInstallationFix');
    const siteInstallationFix = document.getElementById('siteInstallationFix');
    checkSiteInstallationFix.addEventListener('click', (event) => {
      siteInstallationFix.classList.toggle('hidden');
    })
  }
  if (document.getElementById('altitudeWork')) {
    const altitudeWork = document.getElementById('altitudeWork');
    const checkAltitudeWork = document.getElementById('checkAltitudeWork');
    checkAltitudeWork.addEventListener('click', (event) => {
      altitudeWork.classList.toggle('hidden');
    })
  }
  if (document.getElementById('securityCoordinator')) {
    const securityCoordinator = document.getElementById('securityCoordinator');
    const checkSecurityCoordinator = document.getElementById('checkSecurityCoordinator');
    checkSecurityCoordinator.addEventListener('click', (event) => {
      securityCoordinator.classList.toggle('hidden');
    })
  }
}

export { HideForm };
