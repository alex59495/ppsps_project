class Direcct < ApplicationRecord
  has_many :ppsps
  validates :address, presence: true
  validates :phone, presence: true, phone: true
  validates :fax, presence: true
end
