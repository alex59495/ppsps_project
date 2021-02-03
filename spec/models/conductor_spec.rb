require 'rails_helper'

RSpec.describe Conductor, type: :model do
  it { should belong_to(:ppsp).optional }
  it { should belong_to(:worker) }
  it { should belong_to(:user) }
  it { should belong_to(:machine) }
end
