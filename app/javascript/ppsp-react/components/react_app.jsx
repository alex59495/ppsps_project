import React, { Component } from 'react'

import SearchBar from './search_bar'
import ListPpsp from './list_ppsp'

class ReactApp extends Component {
  render () {
    return (
      <div>
        <SearchBar />
        <ListPpsp />
      </div>
    )
  }
}

export default ReactApp