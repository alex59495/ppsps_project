const SelectSubcontractor = () => {
  if (document.querySelector('.form-selected-subcontractor')) {
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
          subcontractor.querySelector('input').checked = true;
        } else {
          subcontractor.querySelector('input').checked = false;
        }
        const list = subcontractor.classList.contains('addlist')
          ? listAjout
          : listInitial;
        list.appendChild(subcontractor);
      });
    });
  }
};
export default SelectSubcontractor;
