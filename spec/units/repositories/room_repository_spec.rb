require 'spec_helper'

describe RoomRepository do
  describe '.sorted_by_name' do
    let(:room_1) { Room.new(name: 'Xyz') }
    let(:room_2) { Room.new(name: 'Abc') }
    let(:room_3) { Room.new(name: 'Def') }

    before do
      RoomRepository.persist(room_1)
      RoomRepository.persist(room_2)
      RoomRepository.persist(room_3)
    end

    it 'should return rooms sorted by name' do
      expect(RoomRepository.sorted_by_name.map(&:name)).to eq ['Abc', 'Def', 'Xyz']
    end
  end
end
