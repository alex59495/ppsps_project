class AntiPoison < ApplicationRecord
  has_many :ppsps
  belongs_to :company
  validates :name, presence: true
  validates :address, presence: true
  validates :phone, presence: true, phone: true

  include PgSearch::Model
  pg_search_scope :search,
    against: [ :name, :address, :phone ],
    using: {
      tsearch: { prefix: true } # <-- allow the fact to search various words incomplete
    }
end
