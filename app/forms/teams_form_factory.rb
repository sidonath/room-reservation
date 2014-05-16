module TeamsFormFactory
  def self.create
    TeamForm.new(Team.new)
  end

  def self.update(team)
    TeamForm.new(team)
  end
end
