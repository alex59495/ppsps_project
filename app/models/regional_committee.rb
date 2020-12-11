class RegionalCommittee < ApplicationRecord
  belongs_to :company
  has_many :ppsps
  validates :name, presence: true
  validates :address, presence: true
  validates :phone, presence: true, phone: true
  validates :fax, presence: true

  include PgSearch::Model
  pg_search_scope :search_regional_committee,
    against: [ :fax, :address, :phone ],
    using: {
      tsearch: { prefix: true } # <-- allow the fact to search various words incomplete
    }
end
