require 'spec_helper'

feature 'User-oriented features' do
  let(:john) { Fabricate :user, username: 'John' }
  let(:dan) { Fabricate :user, username: 'Dan' }
  let(:docker) { Fabricate :business, name: 'Docker' }
  let!(:docker_review) { Fabricate :review, user: dan, business: docker }

  scenario 'user registers with yelpr' do
    user_info = Fabricate.attributes_for :user
    visit root_path
    click_link 'Register'
    fill_in 'Username', with: user_info[:username]
    fill_in 'Email', with: user_info[:email]
    fill_in 'Password', with: user_info[:password]
    click_button 'Sign Up'
    expect(page).to have_content "You're now registered for Yelpr!"
  end

  scenario 'user logs in and logs out' do
    visit root_path
    click_link 'Log In'
    fill_in 'Email', with: john.email
    fill_in 'Password', with: john.password
    click_button 'Log In'
    expect(page).to have_content "logged in as #{john.username}"
    click_link 'Log Out'
    expect(page).to have_content 'Successfully logged out.'
  end

  scenario 'user views own profile and other user profiles' do
    log_in(user: john)
    click_link 'My Profile'
    expect(page).to have_content "#{john.username}'s latest reviews:"
    click_link 'Recent Reviews'
    review_by_dan = find("#payload > a:nth-child(1)")
    review_by_dan.click
    expect(page).to have_content "#{dan.username}'s latest reviews:"
  end
end
