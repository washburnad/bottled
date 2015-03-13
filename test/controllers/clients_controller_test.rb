require 'test_helper'

class ClientsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user = FactoryGirl.create(:user)
    sign_in @user
  end

  test "should get index and new" do
    get :index
    assert :success

    get :new
    assert :success
  end

  test "should get show and edit" do
    client = FactoryGirl.create(:client, user_id: @user.id)

    get :show, id: client.id
    assert :success

    get :edit, id: client.id
    assert :success
  end

  test "should fail show and edit when not signed in" do
    client = FactoryGirl.create(:client, user_id: @user.id)
    sign_out @user

    get :show, id: client.id
    assert_redirected_to new_user_session_path

    get :edit, id: client.id
    assert_redirected_to new_user_session_path
  end

  test "should fail show and edit when wrong user" do
    user2 = FactoryGirl.create(:user)
    client = FactoryGirl.create(:client, user_id: user2.id)

    get :show, id: client.id
    assert_redirected_to root_path

    get :edit, id: client.id
    assert_redirected_to root_path

  end

  test "should create new client" do
    assert_difference('Client.count') do
      post :create, client: {name: 'A client'}
    end
    assert :success
    assert_redirected_to client_path(assigns(:client))
  end 

  test "should fail create when not signed in" do
    sign_out @user

    assert_no_difference('Client.count') do
      post :create, client: {name: 'A client'}
    end
    assert_redirected_to new_user_session_path
  end

  test "should update client" do
    create_client
    put :update, id: @client.id, client: {name: 'New name'}
    @client.reload
    
    assert_equal 'New name', @client.name
    assert :success
    assert_redirected_to client_path(@client)
  end

  test "should fail update with wrong user" do
    create_client
    sign_out @user
    user2 = FactoryGirl.create(:user)
    sign_in user2
    
    puts @user
    puts user2

    put :update, id: @client.id, client: {name: 'New name'}
    @client.reload
    
    assert_not_equal 'New name', @client.name
    assert_redirected_to client_path(@client)
  end

  test "should fail update when signed out" do
    create_client
    sign_out @user

    put :update, id: @client.id, client: {name: 'New name'}
    @client.reload
    
    assert_not_equal 'New name', @client.name
    assert_redirected_to new_user_session_path
  end

  def create_client
    post :create, client: {name: 'A client'}
    @client = Client.last
  end
end
