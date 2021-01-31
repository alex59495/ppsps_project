class ProjectInformation < ApplicationRecord
  has_many :ppsps, inverse_of: :project_information
  belongs_to :site_manager, inverse_of: :project_informations
  belongs_to :team_manager, inverse_of: :project_informations
  accepts_nested_attributes_for :site_manager
  accepts_nested_attributes_for :team_manager
  validates :reference, presence: true
  validates :responsible, presence: true
  validates :phone, presence: true, phone: true
  validates :email, presence: true, email: true
end
