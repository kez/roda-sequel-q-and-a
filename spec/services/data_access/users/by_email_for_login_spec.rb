require_relative '../../../spec_helper'

describe 'ByEmailForLoginSpecTest' do
  subject { DataAccess::Users::ByEmailForLogin.result(email:) }

  describe 'when no email passed' do
    let(:email) { nil }

    it 'fails' do
      expect(subject.failure?).to eql(true)
    end

    it 'returns expected error message' do
      expect(subject.error).to eql('The "email" input on "DataAccess::Users::ByEmailForLogin" does not allow nil values')
    end
  end

  describe 'when an email address is passed' do
    let(:email) { 'email@localhost.dev' }

    describe 'but the user does not exist' do
      it 'passes' do
        expect(subject.success?).to eql(true)
      end

      it 'returns nil user object' do
        expect(subject.user).to eql(nil)
      end
    end

    describe 'and the user does exist' do
      let!(:user) { create(:user, email:) }

      it 'passes' do
        expect(subject.success?).to eql(true)
      end

      it 'returns expected user object' do
        expect(subject.user.email).to eql(user.email)
      end
    end
  end
end
