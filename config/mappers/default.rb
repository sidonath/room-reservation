Application.setup_mapper :default do
  collection :rooms do
    entity Room

    attribute :id,          Integer
    attribute :name,        String
    attribute :description, String
  end

  collection :teams do
    entity Team

    attribute :id,   Integer
    attribute :name, String
  end

  collection :users do
    entity User

    attribute :id,                 Integer
    attribute :email,              String
    attribute :encrypted_password, String
  end
end
