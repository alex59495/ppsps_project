class RiskType < ApplicationRecord
  has_many :risks
  RISK_TYPES = [
    'Risque lié à la circulation',
    'Risque lié aux chutes de hauteur',
    "Risque lié à l'électricité"
  ]
end
