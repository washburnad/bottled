class TimeConversions < ActiveRecord::Base

  def minutes_to_hours(minutes)
    minutes / 60.0
  end
end
