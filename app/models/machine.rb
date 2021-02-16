class Machine < ApplicationRecord
  has_many :conductors
  has_many :workers, through: :conductors
  validates :caces, presence: true
  validates :category, presence: true
  validates :description, presence: true
  validates :image, presence: true

  MACHINES = [
    {
      category: 'Engin de chantier',
      caces: 'Categorie A',
      description: 'Bla bla bla je suis un engin de chantier de categorie A',
      image: 'test_engin_chantier.jpg'
    },
    {
      category: 'Engin de chantier',
      caces: 'Categorie B',
      description: 'Bla bla bla je suis un engin de chantier de categorie B',
      image: 'test_engin_chantier_2.jpg'
    },
    {
      category: 'Pont Roulant',
      caces: 'Categorie A',
      description: 'Bla bla bla je suis un pont roulant de categorie A',
      image: 'test_pont_roulant.png'
    }
  ]
end
