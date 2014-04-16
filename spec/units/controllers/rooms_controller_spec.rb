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
  let(:room) { double(id: 1) }
  let(:action) { described_class.new(repository: RoomRepositaryStub) }

  before do
    allow(RoomRepositaryStub).to receive(:new) { room }
    allow(room).to receive(:save)
  end

  it 'should pass the params when creating a room' do
    params = { room: {
      name: "foo",
      description: "bar"
    } }
    action.call(params)
    expect(RoomRepositaryStub).to have_received(:new).with params[:room]
  end

  it 'should save the room' do
    action.call({})
    expect(room).to have_received(:save)
  end

  it 'should redirect to the rooms index' do
    response = action.call({})
    expect(response.fetch(0)).to eq(302)
    expect(response.fetch(1).fetch('Location')).to eq('/rooms')
  end
end
