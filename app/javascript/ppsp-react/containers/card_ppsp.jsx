import React, { Component } from 'react'
import { connect } from 'react-redux'

import { fetchPpsps } from '../actions/index'


class CardPpsp extends Component {
  handleCard = () => {
    // Fire the opening of the PDF in a new tab
    const win = window.open(`ppsps/${this.props.id}.pdf`, '_blank');
    win.focus();
  }

  handleEdit = (e) => {
    // Avoid to trigger the parent link
    e.stopPropagation();
    // Fire the opening of the edit in a new tab
    const win = window.open(`ppsps/${this.props.id}/edit`, '_blank');
    win.focus();
  }

  handleDelete = (e) => {
    // Avoid to trigger the parent link
    e.stopPropagation();
    // Prevent the default GET or POST method
    e.preventDefault();
    // Allow to print an alert before doing the destroy action
    if (confirm('Êtes-vous sûr de vouloir supprimer cet élément ?')) {
      $.ajax({
        method: 'DELETE',
        url: `/api/v1/ppsps/${this.props.id}`,
        success: function(data) {
          this.props.fetchPpsps();
        }.bind(this),
        error: function(xhr, status, error) {
          alert('Vous ne pouvez pas supprimer cet élément', error);
        }
      });
    }
  }

  render() {
    // If the user if the owner of the PPSP he can edit and delete the PPSP, eles he can't
    if(this.props.currentUser == this.props.user.id) {
      return (
        <div>
          <div className="card-ppsp" onClick={this.handleCard}>
            <div className="card-ppsp-header">
              <div className="card-ppsp-delete" onClick={this.handleDelete}>x</div>
              <div className='card-ppsp-edit' onClick={this.handleEdit}>
                <i className='fas fa-pencil-alt'></i>
              </div>
              <div className="card-ppsp-reference">
                {`Reference ${this.props.reference}`}
              </div>
            </div>
            <div className="card-ppsp-body row">
              <div className="col-7">Lieu du chantier: </div><div className="col-5">{this.props.address}</div>
              <div className="col-7">Date de début: </div><div className="col-5">{ this.props.start_date }</div>
              <div className="col-7">Date de fin: </div><div className="col-5">{ this.props.end_date }</div>
            </div> 
            <div className="card-ppsp-footer">
              { `Créé par ${this.props.user_first_name} ${this.props.user_last_name}` }
            </div>   
          </div>
        </div>
      )
    } {
      return (
        <div>
          <div className="card-ppsp" onClick={this.handleCard}>
            <div className="card-ppsp-reference">
              {`Reference ${this.props.reference}`}
            </div>
            <div className="card-ppsp-body row">
              <div className="col-7">Lieu du chantier: </div><div className="col-5">{this.props.address}</div>
              <div className="col-7">Date de début: </div><div className="col-5">{ this.props.start_date }</div>
              <div className="col-7">Date de fin: </div><div className="col-5">{ this.props.end_date }</div>
            </div> 
            <div className="card-ppsp-footer">
              { `Créé par ${this.props.user_first_name} ${this.props.user_last_name}` }
            </div>   
          </div>
        </div>
      )
    }
  }
}

const mapStateToProps = (state) => {
  return ({
    currentUser: state.currentUser
  });
}

const mapDispatchToProps = (dispatch) => {
  return {
    fetchPpsps: () => dispatch(fetchPpsps()),
  }
}

export default connect(mapStateToProps, mapDispatchToProps)(CardPpsp);
