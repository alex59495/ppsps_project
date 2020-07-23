class SelectedAltitude < ApplicationRecord
  belongs_to :ppsp
  belongs_to :altitude_work
  validates :ppsp_id, uniqueness: { scope: :altitude_work_id }
end
