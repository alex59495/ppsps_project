class Ppsp < ApplicationRecord
  has_one :company
  validates :company, presence: true
  validates :address, presence: true
  validates :start, presence: true
  validates :end, presence: true
  validates :nature, presence: true
  validates :workforce, presence: true
end
