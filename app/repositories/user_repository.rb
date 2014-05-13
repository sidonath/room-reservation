class UserRepository
  include Lotus::Repository

  # Finds a user by ID. If a user does not exist, the block will be called
  def self.fetch(id, &block)
    find(id)
  rescue Lotus::Model::EntityNotFound
    return yield if block_given?
    raise
  end
end
