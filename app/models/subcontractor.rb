class Subcontractor < ApplicationRecord
  has_many :ppsps
  belongs_to :sub_responsible
end
