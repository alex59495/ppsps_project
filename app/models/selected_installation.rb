class SelectedInstallation < ApplicationRecord
  belongs_to :ppsp
  belongs_to :site_installation
  validates :ppsp_id, uniqueness: { scope: :site_installation_id }
end
