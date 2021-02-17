import React from 'react';

import SearchBar from '../containers/search_bar';
import ListPpsp from '../containers/list_ppsp';

const ReactApp = () => (
  <div data-test='component-app'>
    <SearchBar />
    <ListPpsp />
  </div>
);

export default ReactApp;
