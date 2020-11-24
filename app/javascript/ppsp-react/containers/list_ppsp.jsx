import React, { Component } from 'react'
// import { bindActionCreators } from 'redux';
import { connect } from 'react-redux'

import CardPpsp from './card_ppsp'
import { fetchPpsps, loadMore } from '../actions/index'

class ListPpsp extends Component {
  componentDidMount() {
    this.props.fetchPpsps(this.props.showUser);
    this.props.loadMore(this.props.showUser, this.props.page);
    document.addEventListener('scroll', this.trackScrolling);
  }

  componentDidUpdate() {
    document.addEventListener('scroll', this.trackScrolling);
  }

  isBottom(el) {
    return el.getBoundingClientRect().bottom <= window.innerHeight;
  }

  trackScrolling = () => {
    const wrappedElement = document.getElementById('contPpsps');
    if (this.isBottom(wrappedElement) && (this.props.selectedPpsps.length < this.props.ppsps.length)) {
      this.props.loadMore(this.props.showUser, this.props.page);
      document.removeEventListener('scroll', this.trackScrolling);
    }
  };

  render () {
    return (
      <div className="container-ppsp" id="contPpsps">
        {this.props.selectedPpsps.map((ppsp) => {
          return <CardPpsp 
            key={ppsp.id} id={ppsp.id} reference={ppsp.project_information.reference} 
            user_first_name = {ppsp.user.first_name} user_last_name = {ppsp.user.last_name}
            start_date = {ppsp.start_date} end_date = {ppsp.end_date} address={ppsp.address}
            user = {ppsp.user} />
        })}
        <div className="loading" id="loading"></div>
      </div>
    )
  }
}

const mapStateToProps = (state) => {
  return ({
    ppsps: state.ppsps,
    selectedPpsps: state.selectedPpsps,
    showUser: state.showUser,
    page: state.page
  });
}

const mapDispatchToProps = (dispatch) => {
  return {
    fetchPpsps: (showUser) => dispatch(fetchPpsps(showUser)),
    loadMore: (showUser, page) => dispatch(loadMore(showUser, page))
  }
}

export default connect(mapStateToProps, mapDispatchToProps)(ListPpsp);