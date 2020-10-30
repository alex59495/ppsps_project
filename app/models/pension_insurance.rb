class PensionInsurance < ApplicationRecord
  has_many :ppsps
  validates :address, presence: true
  validates :phone, presence: true
  validates :fax, presence: true
end
