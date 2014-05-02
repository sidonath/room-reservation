class TeamForm < Form
  property :name

  validates :name, presence: true
end
