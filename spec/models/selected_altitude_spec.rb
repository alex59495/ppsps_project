require 'rails_helper'

RSpec.describe SelectedAltitude, type: :model do
  it { should belong_to(:ppsp) }
  it { should belong_to(:altitude_work) }
end
