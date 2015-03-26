require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase

  test "Should convert minutes to decimal hours" do 

    assert_equal 0, mins_to_hours(0), "0 minutes is 0 hours"
    assert_equal 1, mins_to_hours(60), "60 minutes is 1 hour"
    assert_equal 2.25, mins_to_hours(135), "135 minutes is 2.25"
  end

  test "Should convert UTC time to date_time string" do 
    time = Time.new(2005, 03, 15, 13, 54, 20, "-04:00")
    assert_equal "2005-03-15 13:54", timeUTC_to_date_time(time)
  end

  test "Should convert UTC time to date string" do 
    time = Time.new(2005, 03, 15, 13, 54, 20, "-04:00")
    assert_equal "2005-Mar-15", timeUTC_to_date(time)
  end

  test "Should convert UTC time to time string" do 
    time = Time.new(2005, 03, 15, 13, 54, 20, "-02:00")
    assert_equal "10:54 am", timeUTC_to_time(time)
  end
  
end
