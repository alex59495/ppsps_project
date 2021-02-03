class Ppsp < ApplicationRecord
  AGGLOMERATIONS = ['Agglomération', 'Hors Agglomération']
  STREET_IMPACTS = ['Hors emprise voirie', 'Voirie en alternance', 'Voirie en route barrée', 'Trottoir']
  RIVER_GUIDANCES = ["Cours d'eau", "Pas de cours d'eau", "Signalisation fluviale"]

  belongs_to :user
  belongs_to :moa
  belongs_to :moe
  belongs_to :project_information, inverse_of: :ppsps
  accepts_nested_attributes_for :project_information
  belongs_to :pension_insurance
  belongs_to :direcct
  belongs_to :regional_committee
  belongs_to :work_medecine
  belongs_to :sos_hand
  belongs_to :anti_poison
  belongs_to :demining
  belongs_to :hospital
  belongs_to :security_coordinator, optional: true
  belongs_to :worksite, inverse_of: :ppsps
  accepts_nested_attributes_for :worksite
  has_many :conductors, dependent: :destroy
  has_many :selected_subcontractors, dependent: :destroy
  has_many :subcontractors, through: :selected_subcontractors
  has_many :selected_installations, dependent: :destroy
  has_many :site_installations, through: :selected_installations
  has_many :selected_altitudes, dependent: :destroy
  has_many :altitude_works, through: :selected_altitudes
  has_many :selected_risks, dependent: :destroy
  has_many :risks, through: :selected_risks
  has_many :selected_lifesavers, dependent: :destroy
  has_many :workers, through: :lifesavers
  validates :agglomeration, presence: true
  validates :street_impact, presence: true
  validates :river_guidance, presence: true
  validates :moa_id, presence: true
  validates :moe_id, presence: true
  validates :demining_id, presence: true
  validates :anti_poison_id, presence: true
  validates :sos_hand_id, presence: true
  validates :regional_committee_id, presence: true
  validates :direcct_id, presence: true
  validates :work_medecine_id, presence: true
  validates :pension_insurance_id, presence: true
  validates :hospital_id, presence: true
  has_one_attached :logo_client
  has_many_attached :annexes
end
