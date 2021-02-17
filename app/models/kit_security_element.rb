class KitSecurityElement < ApplicationRecord
  belongs_to :company
  validates :name, presence: true
  validates :number, presence: true
  validates :company, presence: true
end
