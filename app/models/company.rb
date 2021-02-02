class Company < ApplicationRecord
  has_many :users
  has_many :workers
  has_many :subcontractors
  has_many :anti_poisons
  has_many :deminings
  has_many :security_coordinators
  has_many :hospitals
  has_many :direccts
  has_many :pension_insurances
  has_many :regional_committe
  has_many :sos_hands
  has_many :work_medecines
  has_many :moas
  has_many :moes

  validates :name, presence: true
  validates :address, presence: true
  validates :phone, presence: true, phone: true
  validates :representative, presence: true
  has_one_attached :logo
end
