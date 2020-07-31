class SiteInstallation < ApplicationRecord
  SITE_INSTALLATIONS = [
    { name: "Container",
    mobile: false },
    { name: "Zone de Stockage",
    mobile: false },
    { name: "Bunglaow Réunion",
    mobile: false },
    { name: "Bungalow Vestiaire",
    mobile: false },
    { name: "Bungalow Réfectoire",
    mobile: false },
    { name: "Sanitaires",
    mobile: false },
    { name: "WC chimiques",
    mobile: false },
    { name: "Roulotte",
    mobile: true },
    { name: "Bungalow Ampiroll",
    mobile: true },
    { name: "WC chimiques",
    mobile: true },
    { name: "Container",
    mobile: true },
    { name: "Zone de Stockage",
    mobile: true }
  ]
  has_many :selected_installations
  validates :name, presence: true
  validates :mobile, presence: true
end
