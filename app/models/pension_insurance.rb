class PensionInsurance < ApplicationRecord
  has_many :ppsps
  belongs_to :company
  validates :address, presence: true
  validates :phone, presence: true, phone: true
  validates :fax, presence: true

  include PgSearch::Model
  pg_search_scope :search_pension_insurance,
    against: [ :fax, :address, :phone, ],
    using: {
      tsearch: { prefix: true } # <-- allow the fact to search various words incomplete
    }
end
