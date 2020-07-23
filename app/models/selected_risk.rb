class SelectedRisk < ApplicationRecord
  belongs_to :ppsp
  belongs_to :risk
  validates :ppsp_id, uniqueness: { scope: :risk_id }
end
