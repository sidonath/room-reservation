module UserFormFactory
  def self.create
    RegistrationForm.new(User.new)
  end
end
