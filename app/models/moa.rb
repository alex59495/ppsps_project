class Moa < ApplicationRecord
  has_many :ppsps
  validates :name, presence: true
  validates :address, presence: true
  validates :representative, presence: true
  validates :phone, presence: true
  validates :email, presence: true
end
