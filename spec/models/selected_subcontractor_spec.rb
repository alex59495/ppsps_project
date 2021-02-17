require 'rails_helper'

RSpec.describe SelectedSubcontractor, type: :model do
  it { should belong_to(:ppsp) }
  it { should belong_to(:subcontractor) }
end
