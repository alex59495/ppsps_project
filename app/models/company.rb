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
  has_many :regional_committees
  has_many :sos_hands
  has_many :work_medecines
  has_many :moas
  has_many :moes
  has_many :kit_security_elements, dependent: :destroy
  has_many :project_informations

  validates :name, presence: true
  validates :address, presence: true
  validates :phone, presence: true, phone: true
  validates :representative, presence: true
  has_one_attached :logo
end
