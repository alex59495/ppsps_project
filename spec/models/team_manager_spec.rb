require 'rails_helper'

RSpec.describe TeamManager, type: :model do
  it 'create 1 team_manager' do
    team_manager = create(:team_manager)
    expect(team_manager).to be_kind_of(TeamManager)
  end
end
