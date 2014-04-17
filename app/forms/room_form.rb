class RoomForm < Reform::Form
  property :name
  property :description

  validates :name, presence: true
  validates :description, presence: true
end
