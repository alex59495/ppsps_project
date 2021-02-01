class Conductor < ApplicationRecord
  belongs_to :ppsp
  belongs_to :machine
  belongs_to :worker
end
