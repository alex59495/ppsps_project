require 'rails_helper'

RSpec.describe Conductor, type: :model do
  it { should belong_to(:ppsp).optional }
  it { should belong_to(:worker) }
  it { should belong_to(:user) }
  it { should belong_to(:machine) }

  describe 'Validate uniqueness of machine' do
    subject { create(:conductor) }
    it { should validate_uniqueness_of(:machine).scoped_to(%i[ppsp_id worker_id]) }
  end
end
