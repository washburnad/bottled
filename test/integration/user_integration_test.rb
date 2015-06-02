require 'test_helper'
# require 'warden'

class UserIntegrationTest < ActionDispatch::IntegrationTest
  test 'go to sign in page' do
    visit new_user_session_path
    assert(current_path == new_user_session_path)
  end

  test 'sign in user' do
    visit new_user_session_path
    fill_in('user_email', with: 'cbabbage@example.com')
    fill_in('user_password', with: 'cbabbage')
    click_button('Sign In')
    puts current_path
  end
end