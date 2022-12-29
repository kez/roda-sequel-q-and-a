Sequel.migration do
  change do
    create_table(:questions) do
      primary_key :id
      String :nanoid, null: false
      String :title
      String :body
      foreign_key :user_id, :users, null: false

      DateTime :created_at, default: Sequel.lit('CURRENT_TIMESTAMP')
      DateTime :updated_at, default: Sequel.lit('CURRENT_TIMESTAMP')

      index %i[user_id title], unique: true
    end
  end
end