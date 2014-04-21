require 'lotus/model/adapters/sql_adapter'

Application.setup_adapter do
  name     :default
  type     Lotus::Model::Adapters::SqlAdapter
  mapper   :default
  database 'DATABASE_URL'
end
