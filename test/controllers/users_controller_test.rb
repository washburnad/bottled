require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "Should render user projects" do
    user = FactoryGirl.create(:user)
    sign_in user
    get :project_index, user_id: user.id

    assert_response :success

  end

  test "Should render user tasks" do
    user = FactoryGirl.create(:user)
    sign_in user
    get :task_index, user_id: user.id

    assert_response :success
  end
end
