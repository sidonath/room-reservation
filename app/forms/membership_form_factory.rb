module MembershipFormFactory
  def self.create
    MembershipForm.new(User.new)
  end
end
