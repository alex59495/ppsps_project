class MachineCategory < ApplicationRecord
  validates :name, presence: true
  has_many :machines

  MACHINE_CATEGORIES = ['Engin de chantier', 'Pont roulant']
end
