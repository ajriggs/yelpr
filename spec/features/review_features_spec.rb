require 'spec_helper'

feature 'Review-oriented features' do
  let(:docker) { Fabricate :business, name: 'Docker' }
  let(:john) { Fabricate :user, username: 'John' }

  context 'always' do
    let(:dan) { Fabricate :user, username: 'Dan' }
    let(:apache) { Fabricate :business, name: 'Apache' }
    let!(:docker_review_1) { Fabricate :review, business: docker, user: john }
    let!(:docker_review_2) { Fabricate :review, business: docker, user: dan }
    let!(:apache_review) { Fabricate :review, business: apache, user: dan }

    scenario 'user can see latest review of a business on the home page' do
      visit root_path
      latest_review = find_review_on_page text: docker_review_2.body
      expect(latest_review).to be_present
    end

    scenario 'user can see see a list of the newest reviews on Yelpr' do
      visit reviews_path
      first_docker_review = find_review_on_page text: docker_review_2.body
      expect(first_docker_review).to be_present
      latest_docker_review = find_review_on_page text: docker_review_2.body
      expect(latest_docker_review).to be_present
      first_apache_review = find_review_on_page text: apache_review.body
      expect(first_apache_review).to be_present
    end

  end

  context 'when logged in' do
    before { log_in user: john }
    scenario 'user can review a business' do
      visit business_path(docker)
      review_text = 'Wonderful business. Love what they do for scalability and immutability!'
      fill_in :review_body, with: review_text
      click_button 'Submit'
      expect(page).to have_content "Your review was posted!"
      expect(page).to have_content review_text
    end
  end

  private

    def find_review_on_page(text:)
      find('p', text: text)
    end
end
