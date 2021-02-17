class Moe < ApplicationRecord
  has_many :ppsps
  belongs_to :company
  validates :name, presence: true
  validates :representative, presence: true
  validates :address, presence: true
  validates :phone, presence: true, phone: true
  validates :email, presence: true, email: true

  include PgSearch::Model
  pg_search_scope :search_moe,
                  against: %i[name address phone email representative],
                  using: {
                    tsearch: { prefix: true } # <-- allow the fact to search various words incomplete
                  }

  def self.search(query)
    if query.present?
      search_moe(query)
    else
      # No query? Return all records by name.
      order("name ASC")
    end
  end
end
