import React from 'react'
import Worker from './Worker'

const ItemSelect = ({vehicule}) => {
  const renderItem = vehicule.map(worker => {
    return(
      <Worker worker={worker} key={worker.id}/>
    )
  })

  return (
    <>
      {renderItem}
    </>
  )
}

export default ItemSelect
