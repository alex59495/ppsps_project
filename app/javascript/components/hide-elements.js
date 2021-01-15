const hideForm = () => {
  const btnAddRisk = document.getElementById('checkRisks');
  const btnAddAltitudeWork = document.getElementById('CheckAltitudeWork');
  const btnAddSecurityCoordinator = document.getElementById(
    'checkSecurityCoordinator'
  );

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
  if (btnAddAltitudeWork) {
    const altitudeWork = document.getElementById('altitudeWork');
    btnAddAltitudeWork.addEventListener('click', () => {
      altitudeWork.classList.toggle('hidden');
    });
  }
  if (btnAddSecurityCoordinator) {
    const securityCoordinator = document.getElementById('securityCoordinator');
    btnAddSecurityCoordinator.addEventListener('click', () => {
      securityCoordinator.classList.toggle('hidden');
    });
  }
  if (btnAddRisk) {
    const selectedRisks = document.getElementById('new_selected_risk');
    btnAddRisk.addEventListener('click', () => {
      selectedRisks.classList.toggle('hidden');
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
