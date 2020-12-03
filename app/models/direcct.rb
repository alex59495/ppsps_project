class Direcct < ApplicationRecord
  has_many :ppsps
  belongs_to :company
  validates :address, presence: true
  validates :phone, presence: true, phone: true
  validates :fax, presence: true
end
