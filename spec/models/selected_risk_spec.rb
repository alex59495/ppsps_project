require 'rails_helper'

RSpec.describe SelectedRisk, type: :model do

  it { should belong_to(:ppsp) }
  it { should belong_to(:risk) }
end
