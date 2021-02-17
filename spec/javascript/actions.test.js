import Enzyme from 'enzyme';
import Adapter from 'enzyme-adapter-react-16';

import { storeFactory, initialTestState } from './configs/utilities'
import { searchPpsp } from '../../app/javascript/components/react-ppsp/actions/index'

Enzyme.configure({ adapter: new Adapter() });


describe('test action searchPpsp', () => {
  test('change state when enter reference in the navbar', () => {
    // Initial Test State is defines in configs/utilities
    const search = 'AB'
    const store = storeFactory(initialTestState);
    
    store.dispatch(searchPpsp(search))
    const newSelectedPpsps = store.getState().selectedPpsps
    newSelectedPpsps.forEach(ppsp => {
      expect(ppsp.project_information.reference.toLowerCase()).toContain(search.toLowerCase())
    })
  })
})