class MachineCategory < ApplicationRecord
  validates :name, presence: true
  has_many :machines

  MACHINE_CATEGORIES = [
    'Engin de chantier',
    'Grues mobiles', '
    Ponts roulants et portiques',
    'Gerbeur à conducteur accompagnant',
    'Nacelles / PEMP (plateformes élévatrices de personnel)',
    'Grues à tour',
    'Chariots de manutention à conducteur porté',
    'Grues de chargements'
  ]
end
