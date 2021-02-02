class Risk < ApplicationRecord
  has_many :selected_risks
  validates :name, presence: true
  RISKS = ["Prépartion du terrain", "Mise en place d'un batardeau", "Maçonnerie et réparation des bétons", "Projetage de béton ou de mortier", "Battage de pieux et de palplanches", "Pose de bordures / caniveaux / pierres de taille", "Pose de passerelles / d'éléments béton préfa / Aciers préfa assemblés", "Etanchéité", "Terassement / Démolition d'ouvrage", "Pose de Gardes Corps", "Feraillage - Coffrage - Coulage", "Travaux métallurgiques"]
end
