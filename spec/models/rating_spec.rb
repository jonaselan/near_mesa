require 'rails_helper'

RSpec.describe Rating, type: :model do
  it 'validates presence of value' do
    rating = Rating.new

    expect(rating).to_not be_valid
    expect(rating.errors[:value]).to include("can't be blank")
  end

  it 'validates that value should not be zero' do
    rating = build(:rating, value: 0)

    expect(rating).to_not be_valid
    expect(rating.errors[:value]).to include('must be greater than 0')
  end

  it 'validates that value should not be negative' do
    rating = build(:rating, value: -1)

    expect(rating).to_not be_valid
    expect(rating.errors[:value]).to include('must be greater than 0')
  end

  it 'validates that value should not be greater than ten' do
    rating = build(:rating, value: 11)

    expect(rating).to_not be_valid
    expect(rating.errors[:value]).to include('must be less than or equal to 10')
  end
end
