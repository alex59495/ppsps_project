class Ppsp < ApplicationRecord
  belongs_to :company
  belongs_to :user
  validates :company, presence: true
  validates :address, presence: true
  validates :start, presence: true
  validates :end, presence: true
  validates :nature, presence: true
  validates :workforce, presence: true
end
