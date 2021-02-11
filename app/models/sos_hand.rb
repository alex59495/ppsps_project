class SosHand < ApplicationRecord
  has_many :ppsps
  belongs_to :company
  validates :name, presence: true
  validates :address, presence: true
  validates :phone, presence: true, phone: true

  include PgSearch::Model
  pg_search_scope :search_sos_hand,
                  against: %i[name address phone],
                  using: {
                    tsearch: { prefix: true } # <-- allow the fact to search various words incomplete
                  }

  def self.search(query)
    if query.present?
      search_sos_hand(query)
    else
      order("name ASC")
    end
  end
end
