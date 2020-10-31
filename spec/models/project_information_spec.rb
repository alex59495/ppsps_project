require 'rails_helper'

RSpec.describe ProjectInformation, type: :model do
  it 'create 1 project_information' do
    project_information = create(:project_information)
    expect(project_information).to be_kind_of(ProjectInformation)
  end
end
