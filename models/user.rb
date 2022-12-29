class User < Sequel::Model
  one_to_many :questions
  one_to_many :answers

  def validate
    super
    validates_presence :handle
    validates_unique :email
  end
end
