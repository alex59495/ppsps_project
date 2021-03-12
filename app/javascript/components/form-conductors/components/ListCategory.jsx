import React from 'react'
import InputMachine from './InputCategory'

const ListCategory = ({listCategory, handleSubmitCategory, selectCategory}) => {
  const renderList = listCategory.map(category => {
    return(
        <InputMachine key={category} category={category}/>
    )
  })

  const renderSelectCategory = () => {
    if(listCategory.length === 0) {
      return(
        <b>
          Plus d'option selectionnable
        </b>
      )
    } else {
      return(
        <select className="form-select-category" name="formSelectCategory" id="formSelectCategory" onClick={selectCategory}>
          {renderList}
        </select>
      )
    }
  }
  

  return (
    <form className='container-center-column form-list-categories' onSubmit={handleSubmitCategory}>
      <div className="form-select-category-title">
        Choisir un type d'engin dans la liste ci-dessous si votre chantier implique la conduite d'engins
      </div>
      {renderSelectCategory()}
      <div className='d-flex justify-content-center mt-4'>
        <button type='submit' className='btn-orange' id='submit-category' disabled>OK</button>
      </div>
    </form>
  )
}

export default ListCategory
