require 'rails_helper'

RSpec.describe Location, type: :model do
  it 'validates presence of name' do
    location = Location.new

    expect(location).to_not be_valid
    expect(location.errors[:name]).to include("can't be blank")
  end

  it 'validates uniqueness of email' do
    latitude = '123'
    longitude = '321'
    create(:location, latitude: latitude, longitude: longitude)

    invalid_location = build(:location, latitude: latitude, longitude: longitude)
    valid_location = build(:location, latitude: '22', longitude: '33')
    expect(invalid_location).to_not be_valid
    expect(invalid_location.errors[:latitude]).to include("has already been taken")
    expect(valid_location).to be_valid
    expect(valid_location.errors[:latitude]).to be_empty
  end

end
