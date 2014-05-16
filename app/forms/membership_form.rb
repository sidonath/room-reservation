class MembershipForm < Form
  property :team_id

  validates :team_id,
    presence: true,
    numericality: true
end
