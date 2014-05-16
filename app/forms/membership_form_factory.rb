module MembershipFormFactory
  def self.create(user)
    MembershipForm.new(user)
  end
end
