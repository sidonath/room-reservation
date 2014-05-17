require "spec_helper"

describe AccountController::Join do
  describe 'integrating with repository' do
    let(:params) {{
      user: { team_id: team.id }
    }}
    let(:team) { Team.new(name: 'Avengers') }
    let(:user) { User.new(email: 'tony@starkindustries.com') }
    let(:action) { described_class.new }

    before do
      TeamRepository.create(team)
      UserRepository.create(user)
      allow(action).to receive(:session).and_return(user_id: user.id)
    end

    describe '#call' do
      it 'should assign team ID to user.team_id' do
        action.call(params)
        expect(UserRepository.fetch(user.id).team_id).to eq(team.id)
      end
    end
  end
end
