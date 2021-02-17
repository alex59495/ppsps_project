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
                  against: %i[name address phone email representative],
                  using: {
                    tsearch: { prefix: true } # <-- allow the fact to search various words incomplete
                  }

  def self.search(query)
    if query.present?
      search_security_coordinator(query)
    else
      # No query? Return all records by name.
      order("name ASC")
    end
  end
end
