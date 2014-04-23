module FormFactory
  def self.new_room
    RoomForm.new(Room.new)
  end
end
