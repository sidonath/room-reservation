require 'spec_helper'

class RoomStub
  def self.new() end
end

class RoomFormStub
  def self.new() end
end

class RoomRepositaryStub
  def self.find(id) end
  def self.persist(entity) end
  def self.sorted_by_name() end
end

describe RoomsController::Index do
  let(:room) { Room.new(name: "Foo", description: "Bar") }
  let(:rooms) { [room] }
  let(:action) { described_class.new(repository: RoomRepositaryStub) }

  before do
    allow(RoomRepositaryStub).to receive(:sorted_by_name) { rooms }
  end

  it 'should expose rooms obtained from repository' do
    action.call({})
    expect(action.exposures[:rooms]).to eq(rooms)
  end
end

describe RoomsController::Show do
  let(:room) { Room.new(id: 1, name: "Foo", description: "Bar") }
  let(:params) { { id: '1' } }
  let(:action) { described_class.new(repository: RoomRepositaryStub) }

  before do
    allow(RoomRepositaryStub).to receive(:find).with('1') { room }
  end

  it 'should find the room' do
    action.call(params)
    expect(RoomRepositaryStub).to have_received(:find).with('1')
  end

  it 'should expose the room as model' do
    action.call(params)
    expect(action.exposures[:model]).to eq(room)
  end
end

describe RoomsController::Create do
  let(:room) { Room.new }
  let(:room_form) { RoomForm.new(room) }
  let(:params) { { room: {
      name: "foo",
      description: "bar"
    } } }
  let(:action) { described_class.new(repository: RoomRepositaryStub) }

  before do
    allow(FormFactory).to receive(:new_room) { room_form }
    allow(RoomRepositaryStub).to receive(:persist).with(room)
  end

  it 'should pass the params to room' do
    action.call(params)
    expect(room.name).to eq('foo')
    expect(room.description).to eq('bar')
  end

  it 'should save the room' do
    action.call(params)
    expect(RoomRepositaryStub).to have_received(:persist).with(room)
  end

  it 'should redirect to the rooms index' do
    response = action.call(params)
    expect(response.fetch(0)).to eq(302)
    expect(response.fetch(1).fetch('Location')).to eq('/rooms')
  end

  describe 'given invalid room' do
    before do
      allow(room_form).to receive(:populate) { |params, listener|
        listener.form_invalid
      }
    end

    it 'should set status to 422' do
      response = action.call(params)
      expect(response.fetch(0)).to eq(422)
    end
  end
end

describe RoomsController::Edit do
  let(:room) { Room.new(id: 1, name: "Big Room", description: "It's big.") }
  let(:room_form) { RoomForm.new(room) }
  let(:params) { { id: '1' } }
  let(:action) { described_class.new(repository: RoomRepositaryStub) }

  before do
    allow(RoomRepositaryStub).to receive(:find).with("1") { room }
  end

  it 'should find the room' do
    action.call(params)
    expect(RoomRepositaryStub).to have_received(:find).with('1')
  end
end

describe RoomsController::Update do
  let(:room) { Room.new(id: 1, name: "Big Room", description: "It's big.") }
  let(:room_form) { RoomForm.new(room) }
  let(:params) { {
    id: '1',
    room: {
      name: "Biggest Room",
      description: "It's the biggest room."
    }
  } }
  let(:action) { described_class.new(repository: RoomRepositaryStub) }

  before do
    allow(FormFactory).to receive(:edit_room) { room_form }
    allow(RoomRepositaryStub).to receive(:find).with("1") { room }
    allow(RoomRepositaryStub).to receive(:persist).with(room)
  end

  it 'should pass the params to room' do
    action.call(params)
    expect(room.name).to eq('Biggest Room')
    expect(room.description).to eq("It's the biggest room.")
  end

  it 'should find the room' do
    action.call(params)
    expect(RoomRepositaryStub).to have_received(:find).with('1')
  end

  it 'should save the room' do
    action.call(params)
    expect(RoomRepositaryStub).to have_received(:persist).with(room)
  end

  it 'should redirect to the rooms index' do
    response = action.call(params)
    expect(response.fetch(0)).to eq(302)
    expect(response.fetch(1).fetch('Location')).to eq('/rooms')
  end

  describe 'given invalid room' do
    before do
      allow(room_form).to receive(:populate) { |params, listener|
        listener.form_invalid
      }
    end

    it 'should set status to 422' do
      response = action.call(params)
      expect(response.fetch(0)).to eq(422)
    end
  end
end

describe RoomsController::Destroy do
  let(:room) { Room.new(id: 1, name: "Big Room", description: "It's big.") }
  let(:room_form) { RoomForm.new(room) }
  let(:params) { { id: '1' } }
  let(:action) { described_class.new(repository: RoomRepositaryStub) }

  before do
    allow(RoomRepositaryStub).to receive(:find).with("1") { room }
    allow(RoomRepositaryStub).to receive(:delete).with(room)
  end

  it 'should find the room' do
    action.call(params)
    expect(RoomRepositaryStub).to have_received(:find).with('1')
  end

  it 'should delete the room' do
    action.call(params)
    expect(RoomRepositaryStub).to have_received(:delete).with(room)
  end

  it 'should redirect to the rooms index' do
    response = action.call(params)
    expect(response.fetch(0)).to eq(302)
    expect(response.fetch(1).fetch('Location')).to eq('/rooms')
  end
end
