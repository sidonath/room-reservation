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
