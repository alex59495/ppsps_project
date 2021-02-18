import React from 'react'

const MachineDescription = ({description, image}) => {
  return (
    <div className='d-flex align-items-center mt-4'>
      <div className="image image-form-machine">
        <img src={`/assets/${image}`} alt={`${image}`}/>
      </div>
      <div className='description ml-4'>
        {description}
      </div>
    </div>
  )
}

export default MachineDescription