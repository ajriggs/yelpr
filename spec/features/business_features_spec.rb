require 'spec_helper'

feature 'Business-oriented features' do
  scenario 'user adds a new business to the site' do
    visit new_business_path
    fill_in 'Name', with: 'Docker'
    click_button 'Sign Up'
    expect(find "#payload > a:nth-child(1)").to have_content 'Docker'
  end

  scenario 'user searches for a business and views its profile' do
    docker = Fabricate :business, name: 'Docker'
    visit root_path
    fill_in 'query', with: docker.name
    find('#submit_search').click
    expect(page).to have_content 'We found 1 business related to your search:'
    click_link(docker.name)
    expect(page).to have_content "Latest Reviews of #{docker.name}"
  end
end
