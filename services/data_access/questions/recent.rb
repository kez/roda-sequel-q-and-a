# Returns an array of length `number_of_questions` of type `Question` ordered
# by created date, descending
module DataAccess
  module Questions
    class Recent < Actor
      input :number_of_questions, type: 'Integer', default: 10
      output :questions

      def call
        self.questions = Question.order(Sequel.desc(:created_at)).limit(number_of_questions).all
      end
    end
  end
end
