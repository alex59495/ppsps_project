class Worksite < ApplicationRecord
  has_many :ppsps, inverse_of: :worksite

  validates :address, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :nature, presence: true
  validates :workforce, presence: true
  validates :timetable_start, presence: true
  validates :timetable_end, presence: true
  validates :electrical, inclusion: { in: [true, false] }
  validate :start_date_cant_be_after_end_date
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  def start_date_cant_be_after_end_date
    if start_date.present? && end_date.present? && start_date >= end_date
      errors.add(:end_date, "ne peut pas être avant ou égale à la date de début de chantier")
      errors.add(:start_date, "ne peut pas être après ou égale à la date de fin de chantier")
    end
  end
end
