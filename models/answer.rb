class Answer < Sequel::Model
  many_to_one :question
  many_to_one :user

  def created_at_human
    created_at.strftime(Settings.human_strftime)
  end
end