import React from 'react';

const Spinner = ({ message }) => (
  <div className="loading" id="loading">
    {message}
  </div>
);

Spinner.defaultProps = {
  message: 'Loading...',
};

export default Spinner;
