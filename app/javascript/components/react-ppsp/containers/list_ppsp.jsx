const _ = require('lodash');

import React, { Component } from 'react';
import { connect } from 'react-redux';
import PropTypes from 'prop-types';

import CardPpsp from './card_ppsp';
import { fetchPpsps, loadingTrue, loadMore } from '../actions/index';
import Spinner from '../components/Spinner';

class ListPpsp extends Component {
  componentDidMount() {
    this.props.fetchPpsps(this.props.showUser);
  }

  componentDidUpdate(prevProps) {
    if (!_.isEqual(prevProps.selectedPpsps, this.props.selectedPpsps)){
      document.addEventListener('scroll', this.trackScrolling);
    }
  }

  // Test if we are at the bottom of the page
  isBottom(el) {
    if(el) {
      return el.getBoundingClientRect().bottom <= window.innerHeight;
    }
  }

  // Active the Loading Gif and charge more Ppsps
  chargeLoad(loadMore) {
    // Had to divide into constantes because, can't call the arguments this.props inside the fcallback setTimeout function
    const { showUser, page, search } = this.props;
    this.props.loadingTrue();
    setTimeout(() => {
      loadMore(showUser, page, search);
    }, 1000);
  }

  trackScrolling = () => {
    if (document.getElementById('ppsps-react')) {
      const wrappedElement = document.getElementById('contPpsps');
      if (
        this.isBottom(wrappedElement)
      ) {
        // Show the Loading element + remove and charge the Ppsps in the callback
        this.chargeLoad(this.props.loadMore);
        document.removeEventListener('scroll', this.trackScrolling);
      }
    }
  }

  renderSpinner = (loading) => {
    if (loading) {
      return <Spinner message= 'Chargement'/>;
    } else {
      return null;
    }
  } 

  render() {
    const { selectedPpsps, search, loading } = this.props;
    if(selectedPpsps.length > 0) {
      return (
        <>
          <div className="container-ppsp" id="contPpsps">
            {selectedPpsps.map((ppsp) => (
              <CardPpsp
              key={ppsp.id}
                id={ppsp.id}
                reference={ppsp.project_information.reference}
              user_first_name={ppsp.user.first_name} user_last_name={ppsp.user.last_name}
              start_date={ppsp.worksite.start_date} end_date={ppsp.worksite.end_date} address={ppsp.worksite.address}
              user={ppsp.user}
            />))}
          </div>
          {this.renderSpinner(loading)}
        </>
      )
    } else if(search === '') {
      return (
        <div className="container-flex">
          Vous n'avez pas encore de PPSP créé...
        </div>
      )
    } else {
      return (
        <div className="container-flex">
          Votre recherche n'a retourné aucun résultat...
        </div>
      )
    };
  }
}

const mapStateToProps = (state) => ({
  ppsps: state.ppsps,
  selectedPpsps: state.selectedPpsps,
  showUser: state.showUser,
  page: state.page,
  search: state.search,
  loading: state.loading
});

const mapDispatchToProps = (dispatch) => ({
  fetchPpsps: (showUser) => dispatch(fetchPpsps(showUser)),
  loadMore: (showUser, page, search) => dispatch(loadMore(showUser, page, search)),
  loadingTrue: () => dispatch(loadingTrue())
});

// Validations
ListPpsp.propTypes = {
  selectedPpsps: PropTypes.array.isRequired,
};

export default connect(mapStateToProps, mapDispatchToProps)(ListPpsp);
