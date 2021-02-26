class RiskType < ApplicationRecord
  has_many :risks
  RISK_TYPES = [
    'Risques liés aux circulations',
    'Risques liés aux chutes de hauteur',
    "Risques liés à l'électricité",
    "Risques liés aux manutentions",
    "Risques liés aux instabilités",
    "Risques liés à l'environnement de chantier",
    'Risques transport et hygiène'
  ]
end
