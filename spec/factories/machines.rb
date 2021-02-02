FactoryBot.define do
  factory :machine do
    name { SiteInstallation::SITE_INSTALLATIONS.sample[:name] }
  end
end
