# Returns an array of length `number_of_answers` of type `Answer` for
# the inputted `Question`.  Ordered by created date, descending.
module DataAccess
  module Answers
    class MostRecentForQuestion < Actor
      input :question, type: 'Question'
      input :number_of_answers, type: 'Integer', default: 10
      output :answers

      def call
        self.answers = Answer.filter(question:)
                             .order(Sequel.desc(:created_at))
                             .limit(number_of_answers).all
      end
    end
  end
end
