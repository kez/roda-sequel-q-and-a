require_relative '../spec_helper'
require_relative '../feature_spec_helper'

describe 'App' do
  include Rack::Test::Methods
  include Capybara::DSL

  describe 'valid inputs' do
    it 'behaves as expected' do
      user = User.find_or_create(email: 'user1@localhost.dev', handle: 'user1')

      visit '/'
      expect(page).to have_content('Please note you will need to be')
      visit '/users/login'
      expect(page).to have_content('user1')

      # trigger dummy login
      click_on 'user1'

      expect(page).to have_content('Use the form below to ask a question so others can offer answers')

      expect(Question.where(user:, title: 'Can you help?').count).to eql(0)

      # fill in question
      fill_in 'Title', with: 'Can you help?'
      fill_in 'Body', with: 'with my question'
      click_on 'Ask Question'

      expect(page).to have_content('Question saved!')

      expect(Question.where(user:, title: 'Can you help?').count).to eql(1)
    end
  end
end
