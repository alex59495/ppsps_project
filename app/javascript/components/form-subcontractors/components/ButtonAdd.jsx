import React from 'react';
import Modal from "react-bootstrap/Modal";


const ButtonAdd = ({admin, url, fetchSubcontractorsFormList}) => {

  if (admin === 'true') {
    const csrf = document.querySelector("meta[name='csrf-token']").getAttribute("content");


    const [isOpen, setIsOpen] = React.useState(false);

    const showModal = (e) => {
      e.preventDefault();
      setIsOpen(true);
    };

    const hideModal = () => {
      setIsOpen(false);
    };

    const handleSubmit = (e) => {
      e.preventDefault()
      const name = document.getElementById('subcontractor_name').value;
      const address = document.getElementById('subcontractor_address').value;
      const work = document.getElementById('subcontractor_work').value;
      const responsible_name = document.getElementById('subcontractor_responsible_name').value;
      const responsible_phone = document.getElementById('subcontractor_responsible_phone').value;
      const responsible_email = document.getElementById('subcontractor_responsible_email').value;

      fetch(`${url}/subcontractors`, {
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': csrf
        },
        method: 'POST',
        body: JSON.stringify({
          subcontractor: {
            name: name,
            address: address,
            work: work,
            responsible_email: responsible_email,
            responsible_name: responsible_name,
            responsible_phone: responsible_phone
          }
        })
      })
      .then(response => {
        // Close and reset the modal
        $(".modal-backdrop").hide();
        $("#ModalSubcontractor").hide();
        $(".fade.modal").hide();
        document.getElementById("new_subcontractor").reset();
        $(".modal-open").css({overflow: 'scroll'});
        // Actualize the form list
        fetchSubcontractorsFormList();
      })
      .catch(error => console.log(error))
    }
    
  return (
    <>
      <div className="container-header-form">
        Ajouter des sous-traitants
        <button onClick={showModal} className="icon-btn add-btn" id="SubcontractorDb">
          <div className="add-icon"></div>
          <div className="btn-txt">Ajouter</div>
        </button>
      </div>
      <Modal show={isOpen} onHide={hideModal} id='ModalSubcontractor'>
        <Modal.Header>
          <h5 className="modal-title">Ajouter un sous-traitant</h5>
          <button type="button" className="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true" onClick={hideModal}>&times;</span>
          </button>
        </Modal.Header>
        <Modal.Body>
          <div className="cards-form">
            <form className="simple_form new_subcontractor" id="new_subcontractor" noValidate="" acceptCharset="UTF-8" onSubmit={handleSubmit}>
              <div className="form-group string required subcontractor_name">
                <label className="string required" htmlFor="subcontractor_name">Nom<abbr title="required">*</abbr></label>
                <input className="form-control string required" type="text" name="subcontractor[name]" id="subcontractor_name" required/>
              </div>
              <div className="form-group string required subcontractor_address">
                <label className="string required" htmlFor="subcontractor_address">Adresse<abbr title="required">*</abbr></label>
                <input className="form-control string required" type="text" name="subcontractor[address]" id="subcontractor_address" required/>
              </div>
              <div className="form-group string required subcontractor_work">
                <label className="string required" htmlFor="subcontractor_work">Travail effectué<abbr title="required">*</abbr></label>
                <input className="form-control string required" type="text" name="subcontractor[work]" id="subcontractor_work" required/>
              </div>
              <div className="form-group string required subcontractor_responsible_name">
                <label className="string required" htmlFor="subcontractor_responsible_name">Responsable<abbr title="required">*</abbr></label>
                <input className="form-control string required" type="text" name="subcontractor[responsible_name]" id="subcontractor_responsible_name" required/>
              </div>
              <div className="form-group tel required subcontractor_responsible_phone">
                <label className="tel required" htmlFor="subcontractor_responsible_phone">Téléphone<abbr title="required">*</abbr></label>
                <input className="form-control string tel required" type="tel" name="subcontractor[responsible_phone]" id="subcontractor_responsible_phone" required pattern="(?:(?:\+|00)33|0)\s*[1-9](?:[\s.-]*\d{2}){4}"/>
              </div>
              <div className="form-group email required subcontractor_responsible_email">
                <label className="email required" htmlFor="subcontractor_responsible_email">Email<abbr title="required">*</abbr></label>
                <input className="form-control string email required" type="email" name="subcontractor[responsible_email]" id="subcontractor_responsible_email" required pattern="([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})"/>
              </div>
              <button type='submit' className="btn-blue" id="SubcontractorBtn">Ajouter</button>
            </form>
          </div>
        </Modal.Body>
      </Modal>
    </>
  )}
}

export default ButtonAdd
