class Report < ActiveRecord::Base
  belongs_to :reportable, polymorphic: true
  belongs_to :user


  def total_duration
    total = 0
    self.reportable.events.each do |e|
      if e.duration.present?
        total += e.duration
      end
    end
    return total
  end
  
  def total_billable
    time = total_duration
    if self.reportable.try(:bill_per_minute)
      # If the report is for a client
      rate = self.reportable.try(:bill_per_minute)
    else
      # If reportable belongs to client
      rate = self.reportable.client.try(:bill_per_minute)
    end
    return time * rate
  end

end
