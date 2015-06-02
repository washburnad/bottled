require 'test_helper'
# require 'warden'

class UserIntegrationTest < ActionDispatch::IntegrationTest
  test 'go to sign in page' do
    visit new_user_session_path
    assert(current_path == new_user_session_path)
  end

  test 'sign in user' do
    user = FactoryGirl.create(:user)
    visit new_user_session_path
    fill_in('user_email', with: user.email)
    fill_in('user_password', with: user.password)
    click_link('Sign In')
    # puts current_path
  end

  test 'click to sign up' do
    visit new_user_session_path
    click_on('Sign Up')
    assert(current_path == new_user_registration_path)
    fill_in('user_email', with: 'test@example.com')
    fill_in('user_password', with: 'password')
    fill_in('user_password_confirmation', with: 'password')
    click_link('Sign Up')
    # assert page.has_content? 'Welcome! You have signed up successfully.'
  end
end