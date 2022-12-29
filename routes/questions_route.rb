class App < Roda
  hash_branch 'questions' do |r|
    
    r.is String do |nanoid|
      @question = Question.first(nanoid: nanoid)
      @answers = DataAccess::Answers::MostRecentForQuestion.call(question: @question).answers
      @title = "Question: #{@question.title} on #{Settings.name}}"
      view 'show'
    end

    r.post do
      params = sanitize_params('question', %w[title body])
      actor = Operations::Questions::Create.call(user: current_user, title: params['title'], body: params['body'])

      if actor.success?
        flash[:success] = 'Question saved!'
      else
        flash[:error] = "Question cold not be saved - #{actor.error}"
      end

      r.redirect '/' and return

    end
  end
end
