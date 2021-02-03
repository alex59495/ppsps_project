require 'rails_helper'

RSpec.describe SelectedInstallation, type: :model do
  it { should belong_to(:ppsp) }
  it { should belong_to(:site_installation) }
end
