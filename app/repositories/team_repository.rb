class TeamRepository
  include Lotus::Repository

  def self.sorted_by_name
    query { order(:name) }
  end

  def self.persist(team)
    super(team)
    update_users(team)
  end

  def self.create(team)
    super(team)
    update_users(team)
  end

  def self.update(team)
    super(team)
    update_users(team)
  end

  def self.update_users(team)
    team.users.select { |u| u.team_id.nil? }.each do |user|
      user.team_id = team.id
      UserRepository.persist(user)
    end
  end
end
