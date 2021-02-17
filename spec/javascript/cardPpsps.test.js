import React from 'react';
import { shallow } from 'enzyme';

import Enzyme from 'enzyme';
import Adapter from 'enzyme-adapter-react-16';
import { storeFactory } from './configs/utilities'
import CardPpsp from '../../app/javascript/components/react-ppsp/containers/card_ppsp'

Enzyme.configure({ adapter: new Adapter() });

const defaultProps = {
  user: {
    id: 1
  },
  reference: '',
  address: '',
  user_first_name: '',
  user_last_name: '',
  start_date: '',
  end_date: '',
}

// Il faut prévoir un store ET des props car les deux sont utilisés dans ce composant
const setup = (state = {}, props) => {
  const store = storeFactory(state);
  const setupProps = {...defaultProps, ...props}
  const wrapper = shallow(<CardPpsp store={store} {...setupProps}/>).dive().dive()
  return wrapper
}


test('has access to reference', () => {
  const reference = 'AB1234';
  const wrapper = setup({}, {reference: reference})
  const referenceProp = wrapper.instance().props.reference;
  expect(referenceProp).toBe(reference)
})

test('has access to address', () => {
  const address = '11 rue de la paix';
  const wrapper = setup({}, {address: address})
  const addressProp = wrapper.instance().props.address;
  expect(addressProp).toBe(address)
})

test('has access to user_first_name', () => {
  const userFirstName = 'Julien';
  const wrapper = setup({}, {user_first_name: userFirstName})
  const userFirstNameProp = wrapper.instance().props.user_first_name;
  expect(userFirstNameProp).toBe(userFirstName)
})

test('has access to user_last_name', () => {
  const userLastName = 'Lepers';
  const wrapper = setup({}, {user_last_name: userLastName})
  const userLastNameProp = wrapper.instance().props.user_last_name;
  expect(userLastNameProp).toBe(userLastName)
})

test('has access to start_date', () => {
  const startDate = '12/05/1992';
  const wrapper = setup({}, {start_date: startDate})
  const startDateProp = wrapper.instance().props.start_date;
  expect(startDateProp).toBe(startDate)
})

test('has access to end_date', () => {
  const endDate = '12/06/1995';
  const wrapper = setup({}, {end_date: endDate})
  const endDateProp = wrapper.instance().props.end_date;
  expect(endDateProp).toBe(endDate)
})