import React from 'react';
import { shallow } from 'enzyme';

import {storeFactory, initialTestState} from './configs/utilities'

import App from '../../app/javascript/components/react-ppsp/components/react_app';
import SearchBar from '../../app/javascript/components/react-ppsp/containers/search_bar';
import ListPpsp from '../../app/javascript/components/react-ppsp/containers/list_ppsp';

/**
 * @function setup
 * @param {object} props - Component props specific to this setup
 * @returns {shallowWrapper}
 */

const setupApp = (props={}) => {
  return shallow(<App {...props} />);
};

const setupListPpsp = (initialState) => {
  const store = storeFactory(initialState)
  const wrapper = shallow(<ListPpsp store={store}/>).dive().dive();
  return wrapper;
};

const setupSearchBar = (initialState) => {
  const store = storeFactory(initialState)
  const wrapper = shallow(<SearchBar store={store}/>).dive().dive();
  return wrapper;
};

describe('Test PPSPs index', () => {
  let wrapper
  let wrapperSearchBar

  test('App is rendering without error', () => {
    wrapper = setupApp()
    const ppsps = wrapper.containsAllMatchingElements([<SearchBar />, <ListPpsp />]);
    expect(ppsps).toEqual(true);
  });
  
  
  test('filter on PPSPS when enter something in the SearchBar', () => {
    // Initial Test State is defines in utilities
    wrapperSearchBar = setupSearchBar(initialTestState);
    const searchBar = wrapperSearchBar.find(`[data-test='component-search-ppsps']`)
    wrapperListPpsp = setupListPpsp(initialTestState);
    const listPpsp = wrapperListPpsp.find(`[data-test='component-search-ppsps']`)
    searchBar.simulate('change', { currentTarget: { value: 'AB' }})
  })
})
