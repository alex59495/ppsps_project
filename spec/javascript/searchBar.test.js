import React from 'react';
import { shallow } from 'enzyme';
import Enzyme from 'enzyme';
import Adapter from 'enzyme-adapter-react-16';

import { storeFactory, initialTestState } from './configs/utilities'
import SearchBar from '../../app/javascript/components/react-ppsp/containers/search_bar'

Enzyme.configure({ adapter: new Adapter() });


describe('test searcbar', () => {
  test('change state when enter reference in the navbar', () => {
    // Initial Test State is defines in configs/utilities
    const search = 'AB'
    const store = storeFactory(initialTestState);
    const wrapper = shallow(<SearchBar store={store}/>).dive().dive()
    wrapper.simulate('change', { currentTarget: { value: search }})
    const newSelectedPpsps = store.getState().selectedPpsps
    newSelectedPpsps.forEach(ppsp => {
      expect(ppsp.project_information.reference.toLowerCase()).toContain(search.toLowerCase())
    })
  })

  test('change state when enter name in the navbar', () => {
    // Initial Test State is defines in configs/utilities
    const search = 'Angelique len'
    const store = storeFactory(initialTestState);
    const wrapper = shallow(<SearchBar store={store}/>).dive().dive()
    wrapper.simulate('change', { currentTarget: { value: search }})
    const newSelectedPpsps = store.getState().selectedPpsps
    newSelectedPpsps.forEach(ppsp => {
      expect(ppsp.user.full_name.toLowerCase()).toContain(search.toLowerCase())
    })
  })
})