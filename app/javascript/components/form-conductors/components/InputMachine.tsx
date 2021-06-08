import React from 'react'
import {Machine} from './App'

const InputMachine = ({caces, id} : Machine) : JSX.Element => {
  return (
    <option value={id}>
      {caces}
    </option>
  )
}

export default InputMachine
