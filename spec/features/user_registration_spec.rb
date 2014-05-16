require 'spec_helper'

feature 'User registration' do
  scenario do
    visit '/'

    click_link 'Register'

    fill_in 'user[email]',                 with: 'user@example.com'
    fill_in 'user[password]',              with: 'FooBar123'
    fill_in 'user[password_confirmation]', with: 'FooBar123'
    click_button "Create your account"

    expect(page.body).to match("Your account has been created!")
  end

  feature 'creating a team after registration and joining it' do
    scenario do
      visit '/'
      click_link 'Register'

      fill_in 'user[email]',                 with: 'user@example.com'
      fill_in 'user[password]',              with: 'FooBar123'
      fill_in 'user[password_confirmation]', with: 'FooBar123'
      click_button "Create your account"

      fill_in 'team[name]', with: 'Avengers'
      click_button "Add a team"

      expect(page.body).to match("You are now part of team Avengers!")
    end
  end

  feature 'joining an existing team after registration' do
    before do
      TeamRepository.persist(Team.new(name: "Avengers"))
    end

    scenario do
      visit '/'
      click_link 'Register'

      fill_in 'user[email]',                 with: 'user@example.com'
      fill_in 'user[password]',              with: 'FooBar123'
      fill_in 'user[password_confirmation]', with: 'FooBar123'
      click_button "Create your account"

      select 'Avengers', from: 'user[team_id]'
      click_button "Pick the team"

      expect(page.body).to match("You are now part of team Avengers!")
    end
  end

  scenario 'invalid data' do
    visit '/'

    click_link 'Register'

    fill_in 'user[email]',                 with: ''
    fill_in 'user[password]',              with: ''
    fill_in 'user[password_confirmation]', with: ''
    click_button "Create your account"

    expect(page.body).to_not match("Your account has been created!")
  end
end
