class RegionalCommittee < ApplicationRecord
  belongs_to :company
  has_many :ppsps
  validates :name, presence: true
  validates :address, presence: true
  validates :phone, presence: true, phone: true
  validates :fax, presence: true

  include PgSearch::Model
  pg_search_scope :search_regional_committee,
                  against: %i[fax address phone name],
                  using: {
                    tsearch: { prefix: true } # <-- allow the fact to search various words incomplete
                  }

  def self.search(query)
    if query.present?
      search_regional_committee(query).order(created_at: :asc)
    else
      # No query? Return all records, newest first.
      order("created_at ASC")
    end
  end
end
