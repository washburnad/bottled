require 'test_helper'

class ReportsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "should render list of projects for a client" do
    setup_reports

    xhr :get, :index, { client_id: @client.id }

    assert_response :success
    assert_select "#projects-select", count: 1

  end

  test "should create a client report" do
    setup_reports

    xhr :post, :create, {name: 'Report name', reportable_type: 'Client', reportable_id: @client.id}

    assert_response :success
  end

  def setup_reports
    @user = FactoryGirl.create(:user)
    sign_in @user
    @client = FactoryGirl.create(:client, user_id: @user.id)
    @project = FactoryGirl.create(:project, client_id: @user.id)
    @task = FactoryGirl.create(:task, project_id: @project.id)

  end
end
