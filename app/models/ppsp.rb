class Ppsp < ApplicationRecord
  AGGLOMERATIONS = ['Agglomération', 'Hors Agglomération']
  STREET_IMPACTS = ['Hors emprise voirie', 'Voirie en alternance', 'Voirie en route barrée', 'Trottoir']
  RIVER_GUIDANCES = ["Cours d'eau", "Pas de cours d'eau", "Signalisation fluviale"]

  enum form_steps: {
    ppsp_designation: %i[responsible_id team_manager_id site_manager_id reference name],
    ppsp_master: %i[moe_id moa_id],
    ppsp_prevention: %i[security_coordinator_id regional_committee_id pension_insurance_id direcct_id work_medecine_id],
    ppsp_worksite: %i[nature address start_date end_date],
    ppsp_time_table: %i[
      timetable_summer timetable_summer_start timetable_summer_end
      timetable_summer_start_friday timetable_summer_end_friday
      timetable_winter timetable_winter_start timetable_winter_end
      timetable_winter_start_friday timetable_winter_end_friday
    ],
    ppsp_team_number: %i[num_responsible num_conductor num_worker],
    ppsp_installation: %i[electrical_site water_site plan],
    ppsp_security: %i[infirmary infirmary_text demining_id sos_hand_id anti_poison_id hospital_id],
    ppsp_annexes: []
  }
  attr_accessor :form_step

  belongs_to :user
  belongs_to :moa
  belongs_to :moe
  belongs_to :pension_insurance
  belongs_to :direcct
  belongs_to :regional_committee
  belongs_to :work_medecine
  belongs_to :sos_hand
  belongs_to :anti_poison
  belongs_to :demining
  belongs_to :hospital
  belongs_to :security_coordinator, optional: true
  belongs_to :responsible, class_name: "Worker"
  belongs_to :team_manager, class_name: "Worker"
  belongs_to :site_manager, class_name: "Worker"
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
  has_many :workers, through: :selected_lifesavers
  has_one_attached :logo_client
  validates :logo_client, size: { less_than: 500.kilobytes, message: 'est trop lourd' }, content_type: ['image/png', 'image/jpg', 'image/jpeg']
  has_many_attached :annexes
  has_one_attached :plan_installation
  validates :annexes, size: { less_than: 500.kilobytes, message: 'est trop lourd' }
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  with_options if: -> { required_for_step?(:ppsp_designation) } do
    validates :reference, presence: true
    validates :name, presence: true
    validates :responsible_id, presence: true
    validates :team_manager_id, presence: true
    validates :site_manager_id, presence: true
  end

  with_options if: -> { required_for_step?(:ppsp_master) } do
    validates :moa_id, presence: true
    validates :moe_id, presence: true
  end

  with_options if: -> { required_for_step?(:ppsp_prevention) } do
    validates :security_coordinator_id, presence: true
    validates :regional_committee_id, presence: true
    validates :pension_insurance_id, presence: true
    validates :direcct_id, presence: true
    validates :work_medecine_id, presence: true
  end

  with_options if: -> { required_for_step?(:ppsp_time_table) } do
    validates :timetable_summer, inclusion: { in: [true, false] }
    validates :timetable_winter, inclusion: { in: [true, false] }
    validates :timetable_summer_start, presence: true, if: :summer?
    validates :timetable_summer_end, presence: true, if: :summer?
    validates :timetable_summer_start_friday, presence: true, if: :summer?
    validates :timetable_summer_end_friday, presence: true, if: :summer?
    validates :timetable_summer_start, absence: true, unless: :summer?
    validates :timetable_summer_end, absence: true, unless: :summer?
    validates :timetable_summer_start_friday, absence: true, unless: :summer?
    validates :timetable_summer_end_friday, absence: true, unless: :summer?
    validates :timetable_winter_start, presence: true, if: :winter?
    validates :timetable_winter_end, presence: true, if: :winter?
    validates :timetable_winter_start_friday, presence: true, if: :winter?
    validates :timetable_winter_end_friday, presence: true, if: :winter?
    validates :timetable_winter_start, absence: true, unless: :winter?
    validates :timetable_winter_end, absence: true, unless: :winter?
    validates :timetable_winter_start_friday, absence: true, unless: :winter?
    validates :timetable_winter_end_friday, absence: true, unless: :winter?
  end

  with_options if: -> { required_for_step?(:ppsp_worksite) } do
    validates :address, presence: true
    validates :start_date, presence: true
    validates :end_date, presence: true
    validates :nature, presence: true
    validate :start_date_cant_be_after_end_date
  end

  with_options if: -> { required_for_step?(:ppsp_team_number) } do
    validates :num_responsible, presence: true
    validates :num_responsible, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, if: :num_responsible
    validates :num_conductor, presence: true
    validates :num_conductor, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, if: :num_conductor
    validates :num_worker, presence: true
    validates :num_worker, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, if: :num_worker
  end

  with_options if: -> { required_for_step?(:ppsp_installation) } do
    validates :electrical_site, inclusion: { in: [true, false] }
    validates :water_site, inclusion: { in: [true, false] }
    validates :plan, inclusion: { in: [true, false] }
  end

  with_options if: -> { required_for_step?(:ppsp_security) } do
    validates :infirmary, inclusion: { in: [true, false] }
    validates :infirmary_text, presence: true, if: :infirmary?
    validates :demining_id, presence: true
    validates :sos_hand_id, presence: true
    validates :anti_poison_id, presence: true
    validates :hospital_id, presence: true
  end

  def required_for_step?(step)
    # All fields are required if no form step is present
    return true if form_step.nil?

    # All fields from previous steps are required
    ordered_keys = self.class.form_steps.keys.map(&:to_sym)
    !!(ordered_keys.index(step) <= ordered_keys.index(form_step))
  end

  def summer?
    timetable_summer
  end

  def winter?
    timetable_winter
  end

  def start_date_cant_be_after_end_date
    return unless start_date.present? && end_date.present? && start_date >= end_date

    errors.add(:end_at, "ne peut pas être avant ou égale à la date de début de chantier")
    errors.add(:start_at, "ne peut pas être après ou égale à la date de fin de chantier")
  end
end
