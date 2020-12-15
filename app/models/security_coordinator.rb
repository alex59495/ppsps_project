class SecurityCoordinator < ApplicationRecord
  belongs_to :company
  has_many :ppsps
  validates :name, presence: true
  validates :address, presence: true
  validates :representative, presence: true
  validates :email, presence: true, email: true
  validates :phone, presence: true, phone: true

  include PgSearch::Model
  pg_search_scope :search_security_coordinator,
    against: [ :name, :address, :phone, :email, :representative ],
    using: {
      tsearch: { prefix: true } # <-- allow the fact to search various words incomplete
    }
end
