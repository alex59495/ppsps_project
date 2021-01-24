class AntiPoison < ApplicationRecord
  has_many :ppsps
  belongs_to :company
  validates :name, presence: true
  validates :address, presence: true
  validates :phone, presence: true, phone: true

  include PgSearch::Model
  pg_search_scope :search_anti_poison,
                  against: %i[name address phone],
                  using: {
                    tsearch: { prefix: true } # <-- allow the fact to search various words incomplete
                  }

  def self.search(query)
    if query.present?
      search_anti_poison(query).order(created_at: :asc)
    else
      # No query? Return all records, newest first.
      order("created_at ASC")
    end
  end
end
