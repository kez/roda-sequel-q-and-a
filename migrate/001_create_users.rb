Sequel.migration do
  change do
    create_table(:users) do
      primary_key :id
      String :nanoid, null: false
      String :handle
      String :email
      String :hashed_password

      DateTime :created_at, default: Sequel.lit('CURRENT_TIMESTAMP')
      DateTime :updated_at, default: Sequel.lit('CURRENT_TIMESTAMP')

      index :email, unique: true
      index :handle, unique: true
    end
  end
end