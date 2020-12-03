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
  has_many :subcontractors, dependent: :destroy
  has_many :selected_installations, dependent: :destroy
  has_many :site_installations, through: :selected_installations
  has_many :selected_altitudes, dependent: :destroy
  has_many :altitude_works, through: :selected_altitudes
  has_many :selected_risks, dependent: :destroy
  has_many :risks, through: :selected_risks
  validates :address, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :nature, presence: true
  validates :workforce, presence: true
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
  validate :start_date_cant_be_after_end_date

  def start_date_cant_be_after_end_date
    if start_date.present? && end_date.present? && start_date >= end_date
      errors.add(:end_date, "ne peut pas être avant ou égale à la date de début de chantier")
    end
  end
end
