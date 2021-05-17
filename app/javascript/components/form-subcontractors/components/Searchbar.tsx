import React, { ChangeEventHandler } from 'react'

const Searchbar = ({handleSearch} : {handleSearch: ChangeEventHandler<Element>}) => {
  return (
    <input type="text" className="form-control" placeholder="Rechercher un sous-traitant" onChange={handleSearch}/>
  )
}

export default Searchbar
