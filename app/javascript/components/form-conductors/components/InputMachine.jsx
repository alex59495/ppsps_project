import React from 'react'

const InputMachine = ({machine}) => {
  return (
    <option value={machine.id}>
      {machine.name}
    </option>
  )
}

export default InputMachine
