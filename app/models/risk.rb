class Risk < ApplicationRecord
  has_many :selected_risks
  belongs_to :risk_type
  validates :name, presence: true
  validates :risk_type, presence: true
  validates :file, presence: true
  RISKS = [{
    name: 'Travaux sous circulation routière en agglomération',
    type_id: 1,
    file: 'pdf/risk_type_1_agglo.png'
  }, {
    name: 'Travaux sous circulation routière hors agglo (départementales)',
    type_id: 1,
    file: 'pdf/risk_type_1_agglo.png'
  }, {
    name: 'Travaux sous circulation autoroutière',
    type_id: 1,
    file: 'pdf/risk_type_1_agglo.png'
  }, {
    name: 'Travaux sous circulation ferroviaire',
    type_id: 1,
    file: 'pdf/risk_type_1_agglo.png'
  }, {
    name: 'Travaux sous circulation fluviale',
    type_id: 1,
    file: 'pdf/risk_type_1_agglo.png'
  }, {
    name: 'Circulation sur chantier',
    type_id: 1,
    file: 'pdf/risk_type_1_agglo.png'
  }, {
    name: "Déplacement en véhicule d'entreprise",
    type_id: 1,
    file: 'pdf/risk_type_1_agglo.png'
  }, {
    name: 'Travaux liés aux échaffaudages',
    type_id: 2,
    file: 'pdf/risk_type_1_agglo.png'
  }, {
    name: 'Travaux liés aux nacelles',
    type_id: 2,
    file: 'pdf/risk_type_1_agglo.png'
  }, {
    name: 'Travaux liés aux hauteurs sur bâtiment',
    type_id: 2,
    file: 'pdf/risk_type_1_agglo.png'
  }, {
    name: 'Travaux soummis aux DICTs électriques',
    type_id: 3,
    file: 'pdf/risk_type_1_agglo.png'
  }, {
    name: 'Travaux de branchements sur des lignes électriques',
    type_id: 3,
    file: 'pdf/risk_type_1_agglo.png'
  }, {
    name: "Travaux à l'aide d'outils électroportatifs",
    type_id: 3,
    file: 'pdf/risk_type_1_agglo.png'
  }, {
    name: 'Manutentions mécaniques',
    type_id: 4,
    file: 'pdf/risk_type_1_agglo.png'
  }, {
    name: 'Manutentions manuelles',
    type_id: 4,
    file: 'pdf/risk_type_1_agglo.png'
  }, {
    name: 'Travaux liés aux éboulements',
    type_id: 5,
    file: 'pdf/risk_type_1_agglo.png'
  }, {
    name: "Travaux liés aux renversement de matériel ou d'éléments de contruction",
    type_id: 5,
    file: 'pdf/risk_type_1_agglo.png'
  }, {
    name: "Travaux liés aux chutes d'objets",
    type_id: 5,
    file: 'pdf/risk_type_1_agglo.png'
  }, {
    name: 'Risques physiques (surdités, projections)',
    type_id: 6,
    file: 'pdf/risk_type_1_agglo.png'
  }, {
    name: 'Risques toxicologiques',
    type_id: 6,
    file: 'pdf/risk_type_1_agglo.png'
  }, {
    name: "Risques d'incendie (explosion, asphyxie)",
    type_id: 6,
    file: 'pdf/risk_type_1_agglo.png'
  }, {
    name: 'Risques de noyade',
    type_id: 6,
    file: 'pdf/risk_type_1_agglo.png'
  }, {
    name: 'Transport du personnel',
    type_id: 7,
    file: 'pdf/risk_type_1_agglo.png'
  }, {
    name: 'Hygiène',
    type_id: 7,
    file: 'pdf/risk_type_1_agglo.png'
  }]
end
