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
  
  def amount_billed
  end

end
