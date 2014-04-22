require 'spec_helper'

class RoomStub
  def self.new() end
end

class RoomFormStub
  def self.new() end
end

class RoomRepositaryStub
  def self.all() end
  def self.persist(entity) end
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
  let(:room_form) { RoomForm.new(room) }
  let(:params) { { room: {
      name: "foo",
      description: "bar"
    } } }
  let(:action) { described_class.new(repository: RoomRepositaryStub) }

  before do
    allow(FormProvider).to receive(:new_room) { room_form }
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
