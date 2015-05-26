require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase

  test "Should convert UTC time to date_time string" do 
    time = Time.new(2005, 03, 15, 13, 54, 20, "-04:00")
    assert_equal "2005-03-15 13:54", timeUTC_to_date_time(time)
  end

  test "Should convert UTC time to date string" do 
    time = Time.new(2005, 03, 15, 13, 54, 20, "-04:00")
    assert_equal "2005-Mar-15", timeUTC_to_date(time)
  end

  # test "Should convert UTC time to time string" do 
  #   time = Time.new(2005, 03, 15, 13, 54, 20, "-02:00")
  #   assert_equal "10:54 am", timeUTC_to_time(time)
  # end
  
end
