class ProjectInformation < ApplicationRecord
  has_many :ppsps, inverse_of: :project_information
  belongs_to :responsible, class_name: "Worker"
  belongs_to :team_manager, class_name: "Worker"
  belongs_to :site_manager, class_name: "Worker"
  belongs_to :company
  validates :reference, presence: true
end
