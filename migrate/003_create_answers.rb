Sequel.migration do
  change do
    create_table(:answers) do
      primary_key :id
      String :nanoid, null: false
      String :body
      foreign_key :user_id, :users, null: false
      foreign_key :question_id, :questions, null: false

      boolean :accepted
      DateTime :created_at, default: Sequel.lit('CURRENT_TIMESTAMP')
      DateTime :updated_at, default: Sequel.lit('CURRENT_TIMESTAMP')

    end
  end
end