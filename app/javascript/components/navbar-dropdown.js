const navbarDropdown = () => {
  const navIcon = document.querySelector('.nav-icon');
  if (navIcon) {
    navIcon.addEventListener('click', () => {
      const dropdownContent = document.querySelector('.dropdown-ppsp-content');
      if (dropdownContent.style.display === 'block') {
        dropdownContent.style.display = 'none';
      } else {
        dropdownContent.style.display = 'block';
      }
    });
  }
};

export default navbarDropdown;
