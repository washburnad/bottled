require 'test_helper'

class ClientsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "should get index and new" do
    setup_user
    get :index
    assert_response :success

    get :new
    assert_response :success
  end

  test "should get show and edit" do
    setup_user
    client = FactoryGirl.create(:client, user_id: @user.id)

    get :show, id: client.id
    assert_response :success

    get :edit, id: client.id
    assert_response :success
  end

  test "should fail show and edit when not signed in" do
    client = FactoryGirl.create(:client)
    
    get :show, id: client.id
    assert_redirected_to new_user_session_path

    get :edit, id: client.id
    assert_redirected_to new_user_session_path
  end

  test "should fail show and edit when wrong user" do
    setup_user_and_client
    switch_user

    
    get :show, id: @client.id
    assert_redirected_to root_path

    get :edit, id: @client.id
    assert_redirected_to root_path

  end

  test "should create new client" do
    setup_user
    sign_in @user

    assert_difference('Client.count') do
      post :create, client: {name: 'A client', }
    end
    assert_redirected_to client_path(assigns(:client))
  end 

  test "should fail create when not signed in" do
    assert_no_difference('Client.count') do
      post :create, client: {name: 'A client'}
    end
    assert_redirected_to new_user_session_path
  end

  test "should update client" do
    setup_user_and_client
    put :update, id: @client.id, client: {name: 'New name'}, collaboration: {collaborating_user: @user2.id}
    @client.reload
    
    assert_equal 'New name', @client.name
    assert_redirected_to client_path(@client)
  end

  test "should fail update with wrong user" do
    setup_user_and_client
    switch_user

    put :update, id: @client.id, client: {name: 'New name'}, collaboration: {collaborating_user: @user2.id}
    @client.reload
    
    assert_not_equal 'New name', @client.name
    assert_redirected_to root_path
  end

  test "should fail update when signed out" do
    @client = FactoryGirl.create(:client)
    
    put :update, id: @client.id, client: {name: 'New name'}
    @client.reload
    
    assert_not_equal 'New name', @client.name
    assert_redirected_to new_user_session_path
  end

  def setup_user_and_client
    setup_user
    @client = FactoryGirl.create(:client, user_id: @user.id)
    @user2 = FactoryGirl.create(:user)
  end
end
