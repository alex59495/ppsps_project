import React from 'react'

const searchBar = ({handleSearch}) => {
  return (
    <input type="text" className="form-control" placeholder="Rechercher un compagnon" onChange={handleSearch}/>
  )
}

export default searchBar
