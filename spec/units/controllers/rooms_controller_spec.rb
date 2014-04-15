require 'spec_helper'

describe RoomsController::Index do
  class RoomRepositaryStub
    def self.all() end
  end

  let(:room) { Room.new(name: "Foo", description: "Bar") }
  let(:rooms) { [room] }
  let(:action) { described_class.new(repository: RoomRepositaryStub) }

  before do
    allow(RoomRepositaryStub).to receive(:all) { rooms }
  end

  it 'should expose rooms obtained from repository' do
    action.call({})
    expect(action.exposures[:rooms]).to eq(rooms)
  end
end
