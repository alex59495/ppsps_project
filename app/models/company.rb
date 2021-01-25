class Company < ApplicationRecord
  has_many :users
  validates :name, presence: true
  validates :address, presence: true
  validates :phone, presence: true, phone: true
  validates :representative, presence: true
  has_one_attached :logo
end
