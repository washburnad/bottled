require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "Should total event durations" do
    setup_events
    
    assert_equal 15.00, @report.total_duration
  end

  def setup_events
    @task = FactoryGirl.create(:task)
    5.times do |n|
      duration = n.to_i
      @task.events.create(task_id: @task.id, start_time: Time.now, duration: 3.00)
    end
    @report = FactoryGirl.create(:report, reportable_type: 'Task', reportable_id: @task.id)
  end
end
