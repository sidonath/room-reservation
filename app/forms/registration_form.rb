class RegistrationForm < Form
  property :email
  property :password
  property :password_confirmation, empty: true

  validates :email,
    presence: true,
    format: { with: /@/ }
  validates :password,
    presence: true,
    length: { minimum: 6 },
    confirmation: true
  validates :password_confirmation,
    presence: true
end
