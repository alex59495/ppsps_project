import React from 'react'

const Searchbar = ({handleSearch}) => {
  return (
    <input type="text" className="form-control" placeholder="Rechercher un sous-traitant" onChange={handleSearch}/>
  )
}

export default Searchbar
