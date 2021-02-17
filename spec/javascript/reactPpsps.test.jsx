import React from 'react';
import { shallow } from 'enzyme';
import Enzyme from 'enzyme';
import Adapter from 'enzyme-adapter-react-16';

import {storeFactory, initialTestState} from './configs/utilities'

import App from '../../app/javascript/components/react-ppsp/components/react_app';
import SearchBar from '../../app/javascript/components/react-ppsp/containers/search_bar';
import ListPpsp from '../../app/javascript/components/react-ppsp/containers/list_ppsp';

Enzyme.configure({ adapter: new Adapter() });

/**
 * @function setup
 * @param {object} props - Component props specific to this setup
 * @returns {shallowWrapper}
 */

const setupApp = (initialState) => {
  const store = storeFactory(initialState)
  return shallow(<App store={store} />);
};

describe('Test PPSPs index', () => {
  let wrapper

  test('App is rendering without error', () => {
    wrapper = setupApp()
    const ppsps = wrapper.containsAllMatchingElements([<SearchBar />, <ListPpsp />]);
    expect(ppsps).toEqual(true);
  });
});
