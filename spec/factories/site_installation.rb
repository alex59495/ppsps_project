FactoryBot.define do
  factory :site_installation do
    name { SiteInstallation::SITE_INSTALLATIONS.first[:name] }
    mobile { SiteInstallation::SITE_INSTALLATIONS.first[:mobile] }
  end
end