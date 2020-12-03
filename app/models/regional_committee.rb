class RegionalCommittee < ApplicationRecord
  belongs_to :company
  has_many :ppsps
  validates :name, presence: true
  validates :address, presence: true
  validates :phone, presence: true, phone: true
  validates :fax, presence: true
end
