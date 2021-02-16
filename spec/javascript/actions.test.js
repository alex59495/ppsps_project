import moxios from 'moxios';

import { storeFactory } from './configs/utilities';
import { fetchPpsps } from '../../app/javascript/components/react-ppsp/actions/index';

describe('secretWord action creator', () => {
  beforeEach(() => {
    moxios.install();
  });
  afterEach(() => {
    moxios.uninstall();
  });
  
  test('add response word to state', () => {
    const ppsps = [{
      id: 1,
      project_information: {
        reference: 'AB1234',
      },
      user_first_name: 'Alexis',
      user_last_name: 'Lenoir',
      start_date: '01/01/2020', 
      end_date: '01/01/2021', 
      address: 'Test adress',
      user: {
        full_name: 'Alexis Lenoir'
      }
    }, {
      id: 2,
      project_information: {
        reference: 'AB1235',
      },
      user_first_name: 'Maxence',
      user_last_name: 'Lenoir',
      start_date: '01/01/2020', 
      end_date: '01/01/2021', 
      address: 'Test adress',
      user: {
        full_name: 'Maxence Lenoir'
      }
    }];

    const store = storeFactory();

    moxios.wait(() => {
      const request = moxios.requests.mostRecent();
      request.respondWith({
        status: 200,
        response: ppsps,
      });
    });

    return store.dispatch(fetchPpsps())
      .then(() => {
        const newState = store.getState();
        expect(newState.ppsps).toBe(ppsps)
      })
  })
})