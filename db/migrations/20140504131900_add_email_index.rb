Sequel.migration do
  no_transaction
  up do
    run 'CREATE UNIQUE INDEX CONCURRENTLY lower_email ON users ((lower(email)))'
  end

  down do
    drop_index :lower_email
  end
end
