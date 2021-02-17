require 'rails_helper'

RSpec.describe SelectedLifesaver, type: :model do
  it { should belong_to(:ppsp) }
  it { should belong_to(:worker) }
end
