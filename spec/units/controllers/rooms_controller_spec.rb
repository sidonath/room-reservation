require 'spec_helper'

class RoomRepositaryStub
  def self.all() end
  def self.new() end
end

describe RoomsController::Index do
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

describe RoomsController::Create do
  let(:room) { Room.new }
  let(:params) { { room: {
      name: "foo",
      description: "bar"
    } } }
  let(:action) { described_class.new(repository: RoomRepositaryStub) }

  before do
    allow(RoomRepositaryStub).to receive(:new) { room }
    allow(room).to receive(:save)
  end

  it 'should pass the params when creating a room' do
    action.call(params)
    expect(room.name).to eq('foo')
    expect(room.description).to eq('bar')
  end

  it 'should save the room' do
    action.call(params)
    expect(room).to have_received(:save)
  end

  it 'should redirect to the rooms index' do
    response = action.call(params)
    expect(response.fetch(0)).to eq(302)
    expect(response.fetch(1).fetch('Location')).to eq('/rooms')
  end
end
