class Direcct < ApplicationRecord
  has_many :ppsps
  belongs_to :company
  validates :address, presence: true
  validates :phone, presence: true, phone: true
  validates :fax, presence: true

  include PgSearch::Model
  pg_search_scope :search_direcct,
                  against: %i[fax address phone],
                  using: {
                    tsearch: { prefix: true } # <-- allow the fact to search various words incomplete
                  }

  def self.search(query)
    if query.present?
      search_direcct(query).order(created_at: :asc)
    else
      # No query? Return all records by name.
      order("address ASC")
    end
  end
end
