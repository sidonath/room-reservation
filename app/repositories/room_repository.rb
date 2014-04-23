class RoomRepository
  include Lotus::Repository

  def self.sorted_by_name
    query { order(:name) }
  end
end
