class Worksite < ApplicationRecord
  has_many :ppsps, inverse_of: :worksite

  validates :address, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :nature, presence: true
  validates :num_responsible, presence: true
  validates :num_responsible, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, if: :num_responsible
  validates :num_conductor, presence: true
  validates :num_conductor, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, if: :num_conductor
  validates :num_worker, presence: true
  validates :num_worker, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, if: :num_worker
  validates :electrical_site, inclusion: { in: [true, false] }
  validates :water_site, inclusion: { in: [true, false] }
  validates :plan, inclusion: { in: [true, false] }
  validates :infirmary, inclusion: { in: [true, false] }
  validates :infirmary_text, presence: true, if: :infirmary?
  validate :start_date_cant_be_after_end_date
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  has_one_attached :plan_installation

  validates :plan_installation, attached: true, size: { less_than: 300.kilobytes, message: 'est trop lourd' }, if: :has_a_plan?

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

  def start_date_cant_be_after_end_date
    if start_date.present? && end_date.present? && start_date >= end_date
      errors.add(:end_date, "ne peut pas être avant ou égale à la date de début de chantier")
      errors.add(:start_date, "ne peut pas être après ou égale à la date de fin de chantier")
    end
  end

  def has_a_plan?
    plan == true
  end

  def infirmary?
    infirmary
  end

  def summer?
    timetable_summer
  end

  def winter?
    timetable_winter
  end
end
