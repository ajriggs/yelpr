require 'spec_helper'

describe Review do
  it { should belong_to :user }
  it { should belong_to :business }
  it { should validate_presence_of :body }
  it { should validate_length_of(:body).is_at_least 10 }
  it { should validate_uniqueness_of(:user_id).scoped_to :business_id }
end

describe '#username' do
  let(:user) { Fabricate :user }
  let(:business) { Fabricate :business }

  before { Fabricate :review, user: user, business: business }
  it 'returns the username of the user associated with the review' do
    expect(Review.first.username).to eq user.username
  end
end

describe '#business_name' do
  let(:user) { Fabricate :user }
  let(:business) { Fabricate :business }

  before { Fabricate :review, user: user, business: business }
  it 'returns the username of the user associated with the review' do
    expect(Review.first.business_name).to eq business.name
  end
end
