require_relative '../spec_helper'

describe 'QuestionTest' do
  subject { Question.create(title:, body:, user:) }

  describe 'when parameters are expected' do
    let(:user) { create(:user) }
    let(:title) { 'Title' }
    let(:body) { 'Body' }

    it 'creates a question' do
      created_question = subject.save
      expect(created_question.id).to be > 0
    end

    describe 'when we try and create the same question' do
      it 'fails to create' do
        duplicated_question = Question.new(subject.values.slice(:user_id, :body, :title))
        expect do
          duplicated_question.save
        end.to raise_error(an_instance_of(Sequel::UniqueConstraintViolation).and(having_attributes(message: 'SQLite3::ConstraintException: UNIQUE constraint failed: questions.user_id, questions.title')))
      end
    end
  end
end
