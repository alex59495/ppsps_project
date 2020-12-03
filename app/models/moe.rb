class Moe < ApplicationRecord
  has_many :ppsps
  belongs_to :company
  validates :name, presence: true
  validates :representative, presence: true
  validates :address, presence: true
  validates :phone, presence: true, phone: true
  validates :email, presence: true, email: true
end
