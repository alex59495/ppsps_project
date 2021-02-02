class Conductor < ApplicationRecord
  belongs_to :ppsp, optional: true
  belongs_to :machine
  belongs_to :worker
  belongs_to :user
end
