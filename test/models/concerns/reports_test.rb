require 'test_helper'

class CollaborationsTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "Should generate task_events_html for a report" do
    task = FactoryGirl.create(:task)
    3.times do |n|
      FactoryGirl.create(:event)
    end
    expected = "<li id='task1'><input type='checkbox' ng-model='task1' />Task 1"
    expected += "<ul ng-show='task1'><li id='event1'>Event 1</li><li id='event2'>"
    expected += "Event 2</li><li id='event3'>Event 3</li></ul></li>"
  end

end