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

  test "should render show page" do 
    setup_reports
    @report = FactoryGirl.create(:report, reportable_type: 'Client', reportable_id: @client.id)
    get :show, id: @report.id

    assert_response :success
  end

  def setup_reports
    sign_in_user
    @client = FactoryGirl.create(:client, user_id: @user.id)
    @project = FactoryGirl.create(:project, client_id: @user.id)
    @task = FactoryGirl.create(:task, project_id: @project.id)

  end

  def sign_in_user
    @user = FactoryGirl.create(:user)
    sign_in @user
  end

end
