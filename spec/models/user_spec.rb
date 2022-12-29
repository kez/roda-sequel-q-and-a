require_relative '../spec_helper'

RSpec.describe 'User Model Tests', type: :model do
  subject { User.new(email:, handle:) }

  describe 'when handle missing' do
    let(:email) { 'foo@bar.com' }
    let(:handle) { nil }

    it 'is not valid' do
      expect(subject.valid?).to eql(false)
      expect(subject.errors[:handle].first).to eql('is not present')
    end
  end

  describe 'when we duplicate emails' do
    let(:user) { build(:user, email:, handle: 'foo') }
    let(:email) { 'foo@bar.com' }
    let(:handle) { 'foo' }

    it 'is not valid' do
      subject.save
      expect { user.save }.to raise_error(an_instance_of(Sequel::ValidationFailed).and having_attributes(message: "email is already taken"))
    end
  end

  describe 'when all fields present' do
    let(:email) { 'foo@bar.com' }
    let(:handle) { 'foo' }

    it 'is valid' do
      expect(subject.valid?).to eql(true)
      expect(subject.id).to eql(nil)
    end

    it 'has an id after saving' do
      subject.save
      expect(subject.id).to be > 0
    end
  end
end
