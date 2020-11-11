import React, { Component } from 'react'

class CardPpsp extends Component {
  handleClick = (e) => {
    console.log("hi")
    const win = window.open(`ppsps/1.pdf`, '_blank');
    win.focus();
  }

  render() {
    return (
      <div className="card-ppsp" onClick={this.handleClick}>
        <div className='card-ppsp-edit'>
          <i className='fas fa-pencil-alt'></i>
        </div>
        <div className="card-reference">
          {`Reference ${this.props.reference}`}
        </div>
        <div className="card-body row">
          <div className="col-7">Lieu du chantier: </div><div className="col-5">{this.props.address}</div>
          <div className="col-7">Date de début: </div><div className="col-5">{ this.props.start_date }</div>
          <div className="col-7">Date de fin: </div><div className="col-5">{ this.props.end_date }</div>
        </div> 
        <div className="card-ppsp-footer">
          { `Créé par ${this.props.user_first_name} ${this.props.user_last_name}` }
        </div>   
      </div>
    )
  }
}

export default CardPpsp;
