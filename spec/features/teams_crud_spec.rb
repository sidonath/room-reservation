require 'spec_helper'

feature 'Teams CRUD' do
  specify 'adding a team' do
    visit '/teams/new'

    fill_in "team[name]", :with => "Avengers"
    click_button 'Add a team'

    expect(page.body).to match('The team was created!')
    expect(page.body).to match('Avengers')
  end
end
