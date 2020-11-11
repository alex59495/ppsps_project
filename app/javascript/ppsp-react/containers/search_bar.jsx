import React, { Component } from 'react'
import { connect } from 'react-redux'

import { searchPpsp } from '../actions/index'

class SearchBar extends Component {
  handleChange = (event) => {
    // Save what is entered by the user
    const query = event.currentTarget.value
    this.props.searchPpsp(query)
  }

  render () {
    return (
      <input type="text" placeholder="Chercher une référence" className="form-control" onChange={this.handleChange}/>
    )
  }
}


const mapStateToProps = (state) => {
  return ({
    search: state.search,
    ppsps: state.ppsps
  });
}

const mapDispatchToProps = (dispatch) => {
  return {
    searchPpsp: (query) => dispatch(searchPpsp(query)),
  }
}

export default connect(mapStateToProps, mapDispatchToProps)(SearchBar);