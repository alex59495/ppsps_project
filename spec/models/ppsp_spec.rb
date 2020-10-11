require 'rails_helper'

RSpec.describe Ppsp, type: :model do
  it 'create 1 Ppsp' do
    ppsp = create(:ppsp)
    expect(ppsp).to be_kind_of(Ppsp)
  end
end