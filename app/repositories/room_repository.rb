class RoomRepository
  include Lotus::Repository

  def self.sorted_by_name
    query { order(:name) }.all
  end
end
