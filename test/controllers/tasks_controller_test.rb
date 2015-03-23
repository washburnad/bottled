require 'test_helper'

class TasksControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "Should render show and index" do 
    setup_tasks

    get :index, project_id: @project.id
    assert_response :success

    get :new, project_id: @project.id
    assert_response :success
  end

  test "Should get show and edit" do 
    setup_and_create_task

    get :show, id: @task.id, project_id: @project.id
    assert_response :success

    get :edit, id: @task.id, project_id: @project.id
    assert_response :success
  end

  test "should fail show and edit for wrong user" do 
    setup_and_create_task
    switch_user

    get :show, id: @task.id, project_id: @project.id
    assert_redirected_to root_path

    get :edit, id: @task.id, project_id: @project.id
    assert_redirected_to root_path
  end

  test "should update task" do 
    setup_and_create_task
    put :update, id: @task.id, project_id: @project.id, task: {name: 'New name'}
    @task.reload

    assert_equal 'New name', @task.name
    assert_redirected_to project_task_path(@project, @task)
  end

  test "should fail update for wrong user" do 
    setup_and_create_task
    switch_user

    put :update, id: @task.id, project_id: @project.id, task: {name: 'New name'}
    @task.reload

    refute_equal 'New name', @task.name
    assert_redirected_to root_path
  end

  test "should fail update for not signed in" do 
    setup_and_create_task
    sign_out @user

    put :update, id: @task.id, project_id: @project.id, task: {name: 'New name'}
    @task.reload

    refute_equal 'New name', @task.name
    assert_redirected_to new_user_session_path
  end

  test "should create new task" do
    setup_and_create_task
    assert_difference('Task.count') do 
      post :create, project_id: @project.id, task: {name: 'A task'}
    end
    assert_redirected_to project_task_path(@project, assigns(:task))
  end

  def setup_tasks
    setup_user
    @client = FactoryGirl.create(:client, user_id: @user.id)
    @project = FactoryGirl.create(:project, client_id: @client.id)
  end

  def setup_and_create_task
    setup_tasks
    @task = FactoryGirl.create(:task, project_id: @project.id)
  end

end
