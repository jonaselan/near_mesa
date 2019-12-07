require 'rails_helper'

RSpec.describe User, type: :model do
  it 'validates presence of email' do
    user = User.new

    expect(user).to_not be_valid
    expect(user.errors[:email]).to include("can't be blank")
  end

  it 'validates uniqueness of email' do
    create(:user, email: 'email@email.com')

    user = build(:user, email: 'email@email.com')
    expect(user).to_not be_valid
    expect(user.errors[:email]).to include("has already been taken")
  end

  it 'validates format of email' do
    invalid_user = build(:user, email: 'invalid_email')
    valid_user = build(:user, email: 'valid@email')

    expect(invalid_user).to_not be_valid
    expect(invalid_user.errors[:email]).to include("is invalid")
    expect(valid_user).to be_valid
    expect(valid_user.errors[:email]).to be_empty
  end
end
