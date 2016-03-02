require 'spec_helper'
require 'shoulda-matchers'

describe Business do
  it { should have_many :reviews }
  it { should validate_presence_of :name }
  it { should validate_uniqueness_of :name }
  it { should validate_length_of(:name).is_at_least 3 }
end

describe '#latest_review' do
  let(:business) { Fabricate :business }
  let(:user_1) { Fabricate :user }
  let(:user_2) { Fabricate :user}
  let!(:review_1) { Fabricate :review, user: user_1, business: business }
  let!(:review_2) { Fabricate :review, user: user_2, business: business }


  it 'returns the most recently published review of the business' do
    expect(business.latest_review).to eq review_2
  end
end

describe '#search_by_name' do
  let!(:apple_inc) { Fabricate :business, name: "Apple Inc." }
  let!(:apple_corps) { Fabricate :business, name: "Apple Corps" }

  it 'reuturns no result if there is no match with the query string' do
    expect(Business.search_by_name('Docker').count).to eq 0
  end

  it 'returns all results that contain the query string' do
    expect(Business.search_by_name 'Apple').to include apple_inc, apple_corps
  end

  it 'returns more recent results first' do
    expect(Business.search_by_name('Apple').first).to eq apple_corps
  end

  it 'is not case sensitive' do
    expect(Business.search_by_name('apple').first).to eq apple_corps
  end

end
