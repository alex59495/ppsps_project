class ProjectInformation < ApplicationRecord
  has_many :ppsps
  belongs_to :site_manager
  belongs_to :team_manager
  validates :reference, presence: true
  validates :responsible, presence: true
  validates :phone, presence: true
  validates :email, presence: true
end
