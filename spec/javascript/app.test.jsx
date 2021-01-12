import React from 'react';

import { shallow, configure } from 'enzyme';
import Adapter from 'enzyme-adapter-react-16';

import App from '../../app/javascript/components/react-ppsp/components/react_app';
import SearchBar from '../../app/javascript/components/react-ppsp/containers/search_bar';
import ListPpsp from '../../app/javascript/components/react-ppsp/containers/list_ppsp';

configure({ adapter: new Adapter() });

test('App is rendering without error', () => {
  const app = shallow(<App />);
  const searchBar = app.containsAllMatchingElements([<SearchBar />, <ListPpsp />]);
  expect(searchBar).toEqual(true);
})