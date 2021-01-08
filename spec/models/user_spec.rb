require 'rails_helper'

RSpec.describe User, type: :model do
  it 'create 1 user' do
    user = build(:user)
    expect(user).to be_kind_of(User)
  end

  it { should validate_presence_of(:email)}
  it { should validate_presence_of(:first_name)}
  it { should validate_presence_of(:last_name)}
  it { should validate_presence_of(:password)}
  it { should allow_value(true, false).for(:admin)}

  it 'Invalid password' do
    user = build(:user, password: "AleX1s")
    user.valid?
    expect(user.errors.messages[:password]).to include('doit contenir au moins une lettre miniscule, une lettre majuscule, un numéro et un caractère spécial')
  end

  it { should have_many(:ppsps)}
  it { should belong_to(:company)}
end
