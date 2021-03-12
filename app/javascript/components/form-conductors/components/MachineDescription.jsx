import React from 'react';

const MachineDescription = ({description, image}) => {
  // Use this first request to require the image (with fingerprint) bundled by Webpack
  const img = require(`../../../../assets/images/${image}`)
  return (
    <div className='d-flex align-items-center mt-4'>
      <div className="image image-form-machine">
        <img src={img} alt={`${image}`}/>
      </div>
      <div className='description ml-4'>
        {description}
      </div>
    </div>
  )
}

export default MachineDescription
