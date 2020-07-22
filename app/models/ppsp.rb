class Ppsp < ApplicationRecord
  AGGLOMERATIONS = ['Agglomération', 'Hors Agglomération']
  STREET_IMPACTS = ['Hors emprise voirie', 'Voirie en alternance', 'Voirie en route barrée', 'Trottoir']
  RIVER_GUIDANCES = ["Cours d'eau", "Pas de cours d'eau", "Signalisation fluviale"]


  belongs_to :company
  belongs_to :user
  belongs_to :moa
  belongs_to :moe
  belongs_to :project_information
  has_many :selected_installations
  has_many :site_installations, through: :selected_installations
  validates :address, presence: true
  validates :start, presence: true
  validates :end, presence: true
  validates :nature, presence: true
  validates :workforce, presence: true
  validates :agglomeration, presence: true
  validates :street_impact, presence: true
  validates :river_guidance, presence: true
  validates :company_id, presence: true
  validates :moa_id, presence: true
  validates :moe_id, presence: true
  validates :company_id, presence: true
  validates :project_information_id, presence: true
end
