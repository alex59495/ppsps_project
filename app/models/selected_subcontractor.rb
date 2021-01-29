class SelectedSubcontractor < ApplicationRecord
  belongs_to :ppsp
  belongs_to :subcontractor
  validates :ppsp_id, uniqueness: { scope: :subcontractor_id }
end
