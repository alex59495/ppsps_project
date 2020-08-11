class SiteManager < ApplicationRecord
  has_many :project_informations
  validates :name, presence: true
  validates :phone, presence: true
  validates :email, presence: true
end
