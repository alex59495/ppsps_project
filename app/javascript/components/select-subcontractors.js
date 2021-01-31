const SelectSubcontractor = () => {
  if (document.querySelector('.form-selected-subcontractor')) {
    const options = {
      root: document.querySelector('.form-subcontractors'),
      rootMargin: '0px',
      threshold: 1.0,
    };

    const activateJS = () => {
      // On recupere une liste d'élément dont l'id commence par ppsp_subcontractors
      const listSubcontractors = document.querySelectorAll(
        '[id^="check_ppsp_subcontractors"]'
      );

      const listAjout = document.querySelector('.form-selected-subcontractor');
      const listInitial = document.querySelector(
        '.ppsp_subcontractors.check_boxes.form-group'
      );

      listSubcontractors.forEach((subcontractor) => {
        subcontractor.addEventListener('click', (e) => {
          e.preventDefault();
          // subcontractor.checked = checked;
          subcontractor.classList.toggle('addlist');
          if (subcontractor.classList.contains('addlist')) {
            // eslint-disable-next-line no-param-reassign
            subcontractor.querySelector('input').checked = true;
          } else {
            // eslint-disable-next-line no-param-reassign
            subcontractor.querySelector('input').checked = false;
          }
          const list = subcontractor.classList.contains('addlist')
            ? listAjout
            : listInitial;
          list.appendChild(subcontractor);
        });
      });
    };

    // Those lines are using Intersection Observer : https://developer.mozilla.org/en-US/docs/Web/API/Intersection_Observer_API#creating_an_intersection_observer
    // This allow JS to reload when an element of the DOM is re-render
    const observer = new IntersectionObserver(activateJS, options);
    const target = document.querySelector('.form-subcontractors-list');
    observer.observe(target);
  }
};

export default SelectSubcontractor;
