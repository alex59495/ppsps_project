class Machine < ApplicationRecord
  belongs_to :machine_category
  has_many :conductors
  has_many :workers, through: :conductors
  validates :caces, presence: true
  validates :machine_category, presence: true
  validates :description, presence: true
  validates :image, presence: true

  MACHINES = [
    {
      machine_category_id: 1,
      caces: 'Categorie A',
      description: 'Bla bla bla je suis un engin de chantier de categorie A',
      image: 'machines/test_engin_chantier.jpg'
    },
    {
      machine_category_id: 1,
      caces: 'Categorie B',
      description: 'Bla bla bla je suis un engin de chantier de categorie B',
      image: 'machines/test_engin_chantier_2.jpg'
    },
    {
      machine_category_id: 2,
      caces: 'Categorie A',
      description: 'Bla bla bla je suis un pont roulant de categorie A',
      image: 'machines/test_pont_roulant.png'
    }
  ]
end
