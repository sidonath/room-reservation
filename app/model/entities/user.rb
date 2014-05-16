require 'bcrypt'

class User
  include Lotus::Entity
  include BCrypt

  def password
    return '' if encrypted_password.to_s.blank?
    @password ||= Password.new(encrypted_password)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.encrypted_password = @password
  end
end
