require 'test_helper'

class EventTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test 'Should return amount to be billed' do 
    @user = FactoryGirl.create(:user)
    @client = FactoryGirl.create(:client, user_id: @user.id, billing_rate: 60)
    @project = FactoryGirl.create(:project, client_id: @client.id)
    @task = FactoryGirl.create(:task, project_id: @project.id)
    @event = FactoryGirl.create(:event, duration: 2.5, task_id: @task.id)

    expected = 60 * 2.5

    assert_equal expected, @event.amount_billable

  end

  test "Should return 0 if billing_rate nil" do
    @user = FactoryGirl.create(:user)
    @client = FactoryGirl.create(:client, user_id: @user.id, billing_rate: nil)
    @project = FactoryGirl.create(:project, client_id: @client.id)
    @task = FactoryGirl.create(:task, project_id: @project.id)
    @event = FactoryGirl.create(:event, duration: 2.5, task_id: @task.id)

    assert_equal 0, @event.amount_billable
  end
end
