const hideForm = () => {
  if ($('#siteInstallationType')[0]) {
    const siteInstallationType = $('#siteInstallationType')[0];
    const checkSiteInstallation = $('#checkSiteInstallation')[0];
    checkSiteInstallation.addEventListener('click', () => {
      siteInstallationType.classList.toggle('hidden');
    });
    const checkSiteInstallationMobile = document.getElementById(
      'checkSiteInstallationMobile'
    );
    const siteInstallationMobile = document.getElementById(
      'siteInstallationMobile'
    );
    checkSiteInstallationMobile.addEventListener('click', () => {
      siteInstallationMobile.classList.toggle('hidden');
    });
    const checkSiteInstallationFix = document.getElementById(
      'checkSiteInstallationFix'
    );
    const siteInstallationFix = document.getElementById('siteInstallationFix');
    checkSiteInstallationFix.addEventListener('click', () => {
      siteInstallationFix.classList.toggle('hidden');
    });
  }
  if (document.getElementById('altitudeWork')) {
    const altitudeWork = document.getElementById('altitudeWork');
    const checkAltitudeWork = document.getElementById('checkAltitudeWork');
    checkAltitudeWork.addEventListener('click', () => {
      altitudeWork.classList.toggle('hidden');
    });
  }
  if (document.getElementById('securityCoordinator')) {
    const securityCoordinator = document.getElementById('securityCoordinator');
    const checkSecurityCoordinator = document.getElementById(
      'checkSecurityCoordinator'
    );
    checkSecurityCoordinator.addEventListener('click', () => {
      securityCoordinator.classList.toggle('hidden');
    });
  }
};

const hideInfosSelect = () => {
  if (document.getElementById('cardSelect')) {
    const cardInfo = document.querySelector('.card-info');
    const btnMesInfos = document.getElementById('btn-mes-infos');
    const cardInfoClose = document.getElementById('card-info-close');
    if (btnMesInfos) {
      btnMesInfos.addEventListener('click', () => {
        cardInfo.classList.toggle('hidden');
        btnMesInfos.classList.toggle('hidden');
      });
    }
    if (cardInfoClose) {
      cardInfoClose.addEventListener('click', () => {
        cardInfo.classList.toggle('hidden');
        btnMesInfos.classList.remove('hidden');
      });
    }
  }
};

export { hideForm, hideInfosSelect };
