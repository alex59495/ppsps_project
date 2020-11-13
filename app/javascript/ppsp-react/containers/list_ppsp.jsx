import React, { Component } from 'react'
// import { bindActionCreators } from 'redux';
import { connect } from 'react-redux'

import CardPpsp from './card_ppsp'
import { fetchPpsps } from '../actions/index'

class ListPpsp extends Component {
  componentDidMount() {
      this.props.fetchPpsps(this.props.showUser);
  }

  render () {
    return (
      <div className="container-ppsp">
        {this.props.selectedPpsps.map((ppsp) => {
          return <CardPpsp 
            key={ppsp.id} id={ppsp.id} reference={ppsp.project_information.reference} 
            user_first_name = {ppsp.user.first_name} user_last_name = {ppsp.user.last_name}
            start_date = {ppsp.start_date} end_date = {ppsp.end_date} address={ppsp.address}
            user = {ppsp.user} />
        })}
      </div>
    )
  }
}

const mapStateToProps = (state) => {
  return ({
    selectedPpsps: state.selectedPpsps,
    showUser: state.showUser
  });
}

const mapDispatchToProps = (dispatch) => {
  return {
    fetchPpsps: (showUser) => dispatch(fetchPpsps(showUser)),
  }
}

export default connect(mapStateToProps, mapDispatchToProps)(ListPpsp);