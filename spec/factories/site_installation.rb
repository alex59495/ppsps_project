FactoryBot.define do
  factory :site_installation do
    name { SiteInstallation::SITE_INSTALLATIONS.sample[:name] }
    mobile { true }
  end
end