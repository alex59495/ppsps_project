class SecurityCoordinator < ApplicationRecord
  has_many :ppsps
  validates :name, presence: true
  validates :address, presence: true
  validates :representative, presence: true
  validates :email, presence: true, email: true
  validates :phone, presence: true, phone: true
end
