require 'spec_helper'

describe TeamsController::Create do
  let(:action) { described_class.new }

  describe 'given invalid room' do
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
