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
      machine_category: MachineCategory.first,
      caces: 'Categorie A',
      description: 'Bla bla bla je suis un engin de chantier de categorie A',
      image: 'test_engin_chantier.jpg'
    },
    {
      machine_category: MachineCategory.first,
      caces: 'Categorie B',
      description: 'Bla bla bla je suis un engin de chantier de categorie B',
      image: 'test_engin_chantier_2.jpg'
    },
    {
      machine_category: MachineCategory.second,
      caces: 'Categorie A',
      description: 'Bla bla bla je suis un pont roulant de categorie A',
      image: 'test_pont_roulant.png'
    }
  ]
end
