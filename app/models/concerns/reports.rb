module Reports
  def self.currency(number)
    "$%.2f" % number
  end
end
