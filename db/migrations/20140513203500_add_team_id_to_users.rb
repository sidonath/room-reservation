Sequel.migration do
  change do
    alter_table(:users) do
      add_foreign_key :team_id, :teams
    end
  end
end
