class ProjectInformation < ApplicationRecord
  has_many :ppsps
  belongs_to :site_manager
  belongs_to :team_manager
end
