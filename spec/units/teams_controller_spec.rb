require 'spec_helper'

class TeamRepositaryStub
  def self.find(id) end
  def self.persist(entity) end
end

describe TeamsController::Create do
  let(:action) { described_class.new }

  describe 'given an invalid form' do
    let(:team) { Team.new }
    let(:team_form) { TeamForm.new(team) }
    let(:params) { { team: {} } }

    before do
      allow(TeamsFormFactory).to receive(:create) { team_form }
      allow(team_form).to receive(:populate) { |params, listener|
        listener.form_invalid
      }
    end

    it 'should set status to 422' do
      response = action.call(params)
      expect(response.fetch(0)).to eq(422)
    end
  end
end

describe TeamsController::Update do
  let(:action) { described_class.new(repository: TeamRepositaryStub) }

  describe 'given an invalid form' do
    let(:team) { Team.new(id: 1, name: 'Foo Bar') }
    let(:team_form) { TeamForm.new(team) }
    let(:params) { { id: '1', team: { } } }

    before do
      allow(TeamRepositaryStub).to receive(:find).with('1') { team }
      allow(TeamsFormFactory).to receive(:update) { team_form }
      allow(team_form).to receive(:populate) { |params, listener|
        listener.form_invalid
      }
    end

    it 'should set status to 422' do
      response = action.call(params)
      expect(response.fetch(0)).to eq(422)
    end
  end
end
