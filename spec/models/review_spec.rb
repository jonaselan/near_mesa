require 'rails_helper'

RSpec.describe Review, type: :model do
  it 'validates presence of comment' do
    review = Review.new

    expect(review).to_not be_valid
    expect(review.errors[:comment]).to include("can't be blank")
  end

  it 'validates presence of rating' do
    review = Review.new

    expect(review).to_not be_valid
    expect(review.errors[:rating]).to include("can't be blank")
  end

  it 'validates that rating should not be zero' do
    review = build(:review, rating: 0)

    expect(review).to_not be_valid
    expect(review.errors[:rating]).to include('must be greater than 0')
  end

  it 'validates that rating should not be negative' do
    review = build(:review, rating: -1)

    expect(review).to_not be_valid
    expect(review.errors[:rating]).to include('must be greater than 0')
  end

  it 'validates that rating should not be greater than ten' do
    review = build(:review, rating: 11)

    expect(review).to_not be_valid
    expect(review.errors[:rating]).to include('must be less than or equal to 10')
  end
end
