Sequel.migration do
  no_transaction
  up do
    run 'CREATE INDEX CONCURRENTLY users_team_id_idx ON users (team_id)'
  end

  down do
    drop_index :users_team_id_idx
  end
end
