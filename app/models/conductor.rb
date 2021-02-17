class Conductor < ApplicationRecord
  belongs_to :ppsp, optional: true
  belongs_to :machine
  belongs_to :worker
  belongs_to :user
  validates :machine, uniqueness: { scope: %i[ppsp_id worker_id] }
end
