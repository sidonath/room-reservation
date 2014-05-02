module RoomsFormFactory
  def self.create
    RoomForm.new(Room.new)
  end

  def self.update(room)
    RoomForm.new(room)
  end
end
