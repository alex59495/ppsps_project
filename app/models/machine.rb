class Machine < ApplicationRecord
  has_many :conductors
  validates :name, presence: true

  MACHINES = ['CACES 1', 'CACES 2', 'CACES 3', 'CACES 4', 'CACES 5', 'CACES 6', 'CACES 7', 'CACES 8', 'CACES 9', 'CACES 10', 'CACES 11', 'CACES 12']
end
