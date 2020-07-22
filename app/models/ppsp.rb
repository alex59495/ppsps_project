class Ppsp < ApplicationRecord
  belongs_to :company
  belongs_to :user
  belongs_to :moa
  belongs_to :moe
  belongs_to :project_information
  validates :company, presence: true
  validates :address, presence: true
  validates :start, presence: true
  validates :end, presence: true
  validates :nature, presence: true
  validates :workforce, presence: true
end
