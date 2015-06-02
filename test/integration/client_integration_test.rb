require 'test_helper'
# require 'warden'

class ClientIntegrationTest < ActionDispatch::IntegrationTest
  test 'create client' do
    setup_user
    visit new_client_path
    assert(current_path == new_client_path )

  end

  def setup_user
    @user = FactoryGirl.create(:user)
    login_as(@user, scope: :user)
  end
end