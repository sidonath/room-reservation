module FormFactory
  def self.new_room
    RoomForm.new(Room.new)
  end

  def self.edit_room(room)
    RoomForm.new(room)
  end
end
