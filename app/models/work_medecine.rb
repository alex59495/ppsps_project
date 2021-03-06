class WorkMedecine < ApplicationRecord
  has_many :ppsps
  belongs_to :company
  validates :address, presence: true
  validates :phone, presence: true, phone: true
  validates :fax, presence: true

  include PgSearch::Model
  pg_search_scope :search_work_medecine,
                  against: %i[fax address phone],
                  using: {
                    tsearch: { prefix: true } # <-- allow the fact to search various words incomplete
                  }

  def self.search(query)
    if query.present?
      search_work_medecine(query)
    else
      # No query? Return all records by address.
      order("address ASC")
    end
  end
end
