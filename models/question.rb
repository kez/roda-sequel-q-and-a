class Question < Sequel::Model
  one_to_many :answers
  many_to_one :user

  def validate
    super
    validates_presence :user
    validates_presence :title
    validates_presence :body
  end

  def created_at_human
    created_at.strftime(Settings.human_strftime)
  end
end