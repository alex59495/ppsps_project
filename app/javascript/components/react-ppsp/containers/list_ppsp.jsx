import React, { Component } from 'react';
import { connect } from 'react-redux';
import PropTypes from 'prop-types';

import CardPpsp from './card_ppsp';
import { fetchPpsps, loadMore } from '../actions/index';

class ListPpsp extends Component {
  componentDidMount() {
    this.props.fetchPpsps(this.props.showUser);
    document.addEventListener('scroll', this.trackScrolling);
  }

  componentDidUpdate() {
    document.addEventListener('scroll', this.trackScrolling);
  }

  // Test if we are at the bottom of the page
  isBottom(el) {
    return el.getBoundingClientRect().bottom <= window.innerHeight;
  }

  // Active the Loading Gif and charge more Ppsps
  chargeLoad(removeLoad, loadMore) {
    // Had to divide into constantes because, can't call the arguments this.props inside the fcallback setTimeout function
    const { showUser, page, search } = this.props;
    document.getElementById('loading').style.display = 'block';
    document.getElementById('not-loading').style.display = 'none';
    setTimeout(() => {
      loadMore(showUser, page, search);
      removeLoad();
    }, 1000);
  }

  // Remove the Loading Gif
  removeLoad() {
    document.getElementById('loading').style.display = 'none';
    document.getElementById('not-loading').style.display = 'block';
  }

  trackScrolling = () => {
    if (document.getElementById('ppsps-react')) {
      const wrappedElement = document.getElementById('contPpsps');
      if (
        this.isBottom(wrappedElement) &&
        this.props.selectedPpsps.length < this.props.ppsps.length
      ) {
        // Show the Loading element + remove and charge the Ppsps in the callback
        this.chargeLoad(this.removeLoad, this.props.loadMore);
        document.removeEventListener('scroll', this.trackScrolling);
      }
    }
  }

  render() {
    const { selectedPpsps } = this.props;
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
              start_date={ppsp.start_date} end_date={ppsp.end_date} address={ppsp.address}
              user={ppsp.user}
            />))}
          </div>
          <div className="loading" id="loading" />
          <div className="not-loading" id="not-loading" />
        </>
      )
    } {
      return (
        <div className="container-db-vide">
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
  search : state.search
});

const mapDispatchToProps = (dispatch) => ({
  fetchPpsps: (showUser) => dispatch(fetchPpsps(showUser)),
  loadMore: (showUser, page, search) => dispatch(loadMore(showUser, page, search)),
});

// Validations
ListPpsp.propTypes = {
  selectedPpsps: PropTypes.array.isRequired,
};

export default connect(mapStateToProps, mapDispatchToProps)(ListPpsp);
