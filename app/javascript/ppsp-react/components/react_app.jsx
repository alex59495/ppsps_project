import React, { Component } from 'react'

import SearchBar from '../containers/search_bar'
import ListPpsp from '../containers/list_ppsp'

const ReactApp = () => {
  return (
    <div>
      <SearchBar />
      <ListPpsp />
    </div>
  )
}

export default ReactApp