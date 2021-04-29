const navbarDropdown = () : void => {
  const navIcon : HTMLElement = document.querySelector('.nav-icon');
  if (navIcon) {
    navIcon.addEventListener('click', () => {
      const dropdownContent : HTMLElement = document.querySelector('.dropdown-ppsp-content');
      if (dropdownContent.style.display === 'block') {
        dropdownContent.style.display = 'none';
      } else {
        dropdownContent.style.display = 'block';
      }
    });
  }
};

const navbarTransparency = () : void => {
  const navHome : HTMLElement = document.querySelector('.navbar-home');
  if (navHome) {
    const buttonSignIn = document.getElementById('btn-sign-in');
    const heightBanner = (<HTMLElement>document.querySelector('.home-banner')).offsetHeight
    const heightNav = navHome.offsetHeight
    window.addEventListener('scroll', (e) => {
      if((<Window>e.currentTarget).scrollY > heightBanner - heightNav) {
        buttonSignIn.style.color = 'black';
        navHome.style.backgroundColor = 'rgb(236, 244, 243)';
        navHome.style.borderColor = 'rgb(175, 180, 179)';
      } else {
        buttonSignIn.style.color = 'white';
        navHome.style.backgroundColor = 'rgba(0,0,0,0)';
        navHome.style.borderColor = 'rgba(0,0,0,0)';
      }
    })
  }
};

export {navbarDropdown, navbarTransparency};