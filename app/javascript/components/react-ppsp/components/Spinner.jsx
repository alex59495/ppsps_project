import React from 'react';
import PropTypes from 'prop-types';

const Spinner = ({ message }) => (
  <div className="loading" id="loading">
    {message}
  </div>
);

Spinner.defaultProps = {
  message: 'Chargement...',
};

Spinner.propTypes = {
  message: PropTypes.string,
};

export default Spinner;
