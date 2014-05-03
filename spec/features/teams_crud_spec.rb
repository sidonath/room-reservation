require 'spec_helper'

feature 'Teams CRUD' do
  feature 'adding a team' do
    scenario do
      visit '/teams/new'

      fill_in "team[name]", :with => "Avengers"
      click_button 'Add a team'

      expect(page.body).to match('The team was created!')
      expect(page.body).to match('Avengers')
    end

    scenario 'invalid form' do
      visit '/teams/new'

      fill_in "team[name]", :with => ""
      click_button 'Add a team'

      expect(page.status_code).to eq(422)
    end
  end

  feature 'editing a team' do
    before do
      team = Team.new(name: "Avengers")
      TeamRepository.persist(team)
    end

    scenario do
      visit '/teams'

      click_link 'Edit'
      fill_in "team[name]", :with => "Amazing Avengers"
      click_button 'Update the team'

      expect(page.body).to match('The team was updated!')
      expect(page.body).to match('Amazing Avengers')
    end

    scenario 'invalid form' do
      visit '/teams'

      click_link 'Edit'
      fill_in "team[name]", :with => ""
      click_button 'Update the team'

      expect(page.status_code).to eq(422)
    end
  end

  feature 'removing a team' do
    before do
      team = Team.new(name: "Avengers")
      TeamRepository.persist(team)
    end

    scenario do
      visit '/teams'

      click_button 'Delete'

      expect(page.body).to match('The team was deleted!')
      expect(page.body).to_not match('Avengers')
    end
  end

  feature 'viewing team details' do
    before do
      team = Team.new(name: "Avengers")
      TeamRepository.persist(team)
    end

    scenario do
      visit '/teams'

      click_link 'Avengers'

      expect(page.body).to match('Avengers')
    end
  end
end
