require_relative '../../../spec_helper'

describe 'CreateTest' do
  subject { Operations::Questions::Create.result(title:, user:, body:) }

  describe 'when parameters are invalid' do
    describe 'when there is no title' do
      let(:title) { nil }
      let(:body) { 'question body' }
      let(:user) { build(:user) }

      it 'fails' do
        expect(subject.failure?).to eql(true)
      end

      it 'returns expected error message' do
        expect(subject.error).to eql('The "title" input on "Operations::Questions::Create" does not allow nil values')
      end
    end

    describe 'when there is no user' do
      let(:title) { 'Can you help me?' }
      let(:body) { '...with this challenging question' }
      let(:user) { nil }

      it 'fails' do
        expect(subject.failure?).to eql(true)
      end

      it 'returns expected error message' do
        expect(subject.error).to eql('The "user" input on "Operations::Questions::Create" does not allow nil values')
      end
    end
  end

  describe 'when paramters are expected' do
    let(:title) { 'Can you help me?' }
    let(:body) { '...with this challenging question' }
    let(:user) { create(:user) }

    it 'succeeds' do
      expect(subject.success?).to eql(true)
    end

    it 'sets a nanoid (friendly id)' do
      expect(subject.question.nanoid).not_to eql('')
    end
  end
end
