module Operations
  module Questions
    class Create < Actor
      fail_on ServiceActor::ArgumentError

      input :user, type: 'User'
      input :title, type: 'String'
      input :body, type: 'String'
      output :question

      def call
        self.question = Question.create(user: user, title:, body:)
      end
    end
  end
end
