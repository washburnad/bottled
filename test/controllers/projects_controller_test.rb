require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "Should render index and new" do
    setup_user_and_client
    get :index, client_id: @client.id
    assert_response :success

    get :new, client_id: @client.id
    assert_response :success
  end

  test "Should create project" do
    setup_user_and_client
    assert_difference('Project.count') do
      post :create, client_id: @client.id, project: { name: "Project name"}
    end
    assert_response :found
    assert_redirected_to client_project_path(@client, assigns(:project))
  end

  test "Should update" do
    setup_user_and_client
    project = FactoryGirl.create(:project, client_id: @client.id)
    put :update, id: project.id, client_id: @client.id, project: { name: "New name"}
    project.reload

    assert_response :found
    assert_equal "New name", project.name, "Should update name to 'New name'"
  end

  test "Should redirect if not signed in" do
    get :index, client_id: 1
    assert_redirected_to new_user_session_path

    get :new, client_id: 1
    assert_redirected_to new_user_session_path

    post :create, client_id: 1, project: { name: "Project name"}
    assert_redirected_to new_user_session_path
  end

  test "Should fail update with wrong user" do
    setup_user_and_client
    project = FactoryGirl.create(:project, client_id: @client.id)
    sign_out @user
    user2 = FactoryGirl.create(:user)
    sign_in user2
    put :update, id: project.id, client_id: @client.id, project: { name: "New name"}
    project.reload

    assert_not_equal "New name", project.name
    assert_redirected_to root_path
  end

  def setup_user_and_client
    setup_user
    @client = FactoryGirl.create(:client, user_id: @user.id)
  end
end
