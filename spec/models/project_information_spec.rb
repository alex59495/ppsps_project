require 'rails_helper'

RSpec.describe ProjectInformation, type: :model do
  it 'create 1 project_information' do
    project_information = create(:project_information)
    expect(project_information).to be_kind_of(ProjectInformation)
  end

  it { should validate_presence_of(:reference) }
  it { should validate_presence_of(:name) }

  it { should belong_to(:team_manager) }
  it { should belong_to(:site_manager) }
  it { should belong_to(:responsible) }
  it { should have_many(:ppsps) }
end
