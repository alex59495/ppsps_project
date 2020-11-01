require 'rails_helper'

RSpec.describe SiteManager, type: :model do
  it 'create 1 site_manager' do
    site_manager = create(:site_manager)
    expect(site_manager).to be_kind_of(SiteManager)
  end

  it { should validate_presence_of(:name)}
  it { should validate_presence_of(:phone)}
  it { should validate_presence_of(:email)}

  it { should have_many(:project_informations)}
end
