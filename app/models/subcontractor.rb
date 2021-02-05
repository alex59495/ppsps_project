class Subcontractor < ApplicationRecord
  has_many :selected_subcontractors
  belongs_to :company
  validates :name, presence: true
  validates :address, presence: true
  validates :work, presence: true
  validates :responsible_name, presence: true
  validates :responsible_phone, presence: true, phone: true
  validates :responsible_email, presence: true, email: true

  include PgSearch::Model
  pg_search_scope :subcontractor,
                  against: %i[name work address responsible_name responsible_email responsible_phone],
                  using: {
                    tsearch: { prefix: true } # <-- allow the fact to search various words incomplete
                  }

  def self.search(query)
    if query.present?
      subcontractor(query).order(created_at: :asc)
    else
      # No query? Return all records, newest first.
      order("created_at ASC")
    end
  end
end
