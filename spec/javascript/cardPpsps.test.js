import React from 'react';
import { shallow } from 'enzyme';

import Enzyme from 'enzyme';
import Adapter from 'enzyme-adapter-react-16';
import { storeFactory } from './configs/utilities'
import CardPpsp from '../../app/javascript/components/react-ppsp/containers/card_ppsp'

Enzyme.configure({ adapter: new Adapter() });

const setup = (state = {}) => {
  const store = storeFactory(state);
  const wrapper = shallow(<CardPpsp store={store} />).dive().dive()
  console.log(wrapper.debug())
  return wrapper
}


test('has access to reference', () => {
  const reference = 'AB1234';
  const wrapper = setup({ 
    reference,
    user: { id: 1} 
  })
  const referenceProp = wrapper.instance().props.reference;
  expect(referenceProp).toBe(reference)
})