import React from 'react'
import InputMachine from './InputCategory'

const ListCategory = ({listCategory, handleCategory, selectCategory}) => {
  const renderList = listCategory.map(category => {
    return(
        <InputMachine key={category} category={category}/>
    )
  })
  

  return (
    <form className='container-center-column form-list-categories' onSubmit={handleCategory}>
      <div className="form-select-machines-title">
        Choisir un type d'engin dans la liste ci-dessous si votre chantier implique la conduite d'engins
      </div>
      <select className="form-select-machines" onClick={selectCategory}>
        {renderList}
      </select>
      <div className='d-flex justify-content-center mt-4'>
        <button type='submit' className='btn-orange' id='submit-category' disabled>OK</button>
      </div>
    </form>
  )
}

export default ListCategory
