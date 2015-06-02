require 'test_helper'
# require 'warden'

class ClientIntegrationTest < ActionDispatch::IntegrationTest
  test 'create client' do
    setup_user
    visit new_client_path
    assert current_path == new_client_path
    fill_in 'client_name', with: 'Test Client'
    click_on 'Save'
    assert current_path == client_path(Client.last)
  end

  test 'edit client' do
    setup_user
    client = @user.clients.create(name: 'Test Client')
    visit edit_client_path client
    fill_in 'client_name', with: 'New client name'
    click_on 'Save'
    client.reload
    assert current_path == client_path(client)
    assert_equal 'New client name', client.name
  end

  def setup_user
    @user = FactoryGirl.create(:user)
    login_as(@user, scope: :user)
  end
end