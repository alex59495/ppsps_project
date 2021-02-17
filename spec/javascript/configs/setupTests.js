// Don't use actually, the point is to create a jest.config.js file and call this files there

import Adapter from 'enzyme-adapter-react-16';
import Enzyme from 'enzyme';


Enzyme.configure({ adapter: new Adapter() });