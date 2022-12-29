module Operations
  module Answers
    class Create < Actor
      input :user, type: 'User'
      input :question, type: 'Question'
      input :body, type: 'String'
      output :answer

      def call
        self.answer = Answer
                      .create(user_id: user.id, question_id: question.id, body:)
      end
    end
  end
end
