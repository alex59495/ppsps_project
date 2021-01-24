class PensionInsurance < ApplicationRecord
  has_many :ppsps
  belongs_to :company
  validates :address, presence: true
  validates :phone, presence: true, phone: true
  validates :fax, presence: true

  include PgSearch::Model
  pg_search_scope :search_pension_insurance,
                  against: %i[fax address phone],
                  using: {
                    tsearch: { prefix: true } # <-- allow the fact to search various words incomplete
                  }

  def self.search(query)
    if query.present?
      search_pension_insurance(query).order(created_at: :asc)
    else
      # No query? Return all records, newest first.
      order("created_at ASC")
    end
  end
end
