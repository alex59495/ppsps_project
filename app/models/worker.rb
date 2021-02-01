class Worker < ApplicationRecord
  belongs_to :company
  has_many :conductors
  validates :lifesaver, inclusion: { in: [true, false] }
  validates :conductor, inclusion: { in: [true, false] }
  validates :first_name, presence: true
  validates :last_name, presence: true

  include PgSearch::Model
  pg_search_scope :search_worker,
                  against: %i[first_name last_name],
                  using: {
                    tsearch: { prefix: true } # <-- allow the fact to search various words incomplete
                  }

  def self.search(query)
    if query.present?
      search_worker(query).order(created_at: :asc)
    else
      # No query? Return all records, newest first.
      order("created_at ASC")
    end
  end
end
