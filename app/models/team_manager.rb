class TeamManager < ApplicationRecord
  has_many :project_informations, inverse_of: :team_manager
  validates :name, presence: true
  validates :phone, presence: true, phone: true
  validates :email, presence: true, email: true
end
