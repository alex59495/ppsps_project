import React from 'react'

const InputMachine = ({category}) => {
  return (
    <option value={category}>
      {`${category}`}
    </option>
  )
}

export default InputMachine
