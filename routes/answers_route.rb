class App < Roda
  hash_branch 'answers' do |r|
    
    r.is String do |nanoid|
      @question = Question.first(nanoid: nanoid)
      @title = "Question: #{@question.title} on #{Settings.name}}"
      view 'show'
    end

    r.post do
      params = sanitize_params('answer', %w[body])
      question = Question.first(nanoid: r.params['question_nanoid'])
      actor = Operations::Answers::Create.call(user: current_user, question: question, body: params['body'])

      if actor.success?
        flash[:success] = 'Answer saved!'
      else
        flash[:error] = "Answer cold not be saved - #{actor.error}"
      end

      r.redirect "/questions/#{question.nanoid}" and return

    end
  end
end
