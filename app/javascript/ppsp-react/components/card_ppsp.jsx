import React, { Component } from 'react'

const CardPpsp = (props) => {
  return (
    <div className="card-ppsp">
      <div  className='card-ppsp-edit'>
        <i className='fas fa-pencil-alt'></i>
      </div>
      <div className="card-reference">
        {`Reference ${props.reference}`}
      </div>
    </div>
  )
}

export default CardPpsp;
