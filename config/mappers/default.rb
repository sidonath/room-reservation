Application.setup_mapper :default do
  collection :rooms do
    entity Room

    attribute :id,          Integer
    attribute :name,        String
    attribute :description, String
  end
end
