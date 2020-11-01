require 'rails_helper'

RSpec.describe TeamManager, type: :model do
  it 'create 1 team_manager' do
    team_manager = create(:team_manager)
    expect(team_manager).to be_kind_of(TeamManager)
  end

  it { should validate_presence_of(:name)}
  it { should validate_presence_of(:phone)}
  it { should validate_presence_of(:email)}

  it { should have_many(:project_informations)}
end
