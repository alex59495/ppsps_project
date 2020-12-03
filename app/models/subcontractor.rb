class Subcontractor < ApplicationRecord
  belongs_to :ppsp
  validates :name, presence: true
  validates :address, presence: true
  validates :work, presence: true
  validates :responsible_name, presence: true
  validates :responsible_phone, presence: true, phone: true
  validates :responsible_email, presence: true, email: true
end
