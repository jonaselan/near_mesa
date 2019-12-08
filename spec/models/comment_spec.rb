require 'rails_helper'

RSpec.describe Comment, type: :model do
  it 'validates presence of body' do
    comment = Comment.new

    expect(comment).to_not be_valid
    expect(comment.errors[:body]).to include("can't be blank")
  end
end
