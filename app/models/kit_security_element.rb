class KitSecurityElement < ApplicationRecord
  belongs_to :company
  validates :name, presence: true
  validates :number, presence: true
end
