import React from 'react';

interface PropsCategory {
  category: string
}

const InputMachine = ({category} : PropsCategory ) : JSX.Element => {
  return (
    <option value={category}>
      {`${category}`}
    </option>
  )
}

export default InputMachine
