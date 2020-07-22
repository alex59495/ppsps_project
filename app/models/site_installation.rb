class SiteInstallation < ApplicationRecord
  SITE_INSTALLATIONS = ["Container", "Zone de stockage", "Bungalow réunion", "Bungalow vestiaires", "Sanitaires", "WC chimiques", "Roulotte", "Bungalow Ampiroll", "WC chimique", "Zone de stockage"]
  has_many :selected_installations
end
