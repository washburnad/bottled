FactoryGirl.define do
 
  factory :user do
    sequence :email do |n|
      "bottled#{n}@example.com"
    end
    password "gF%478HiJQ"
    password_confirmation "gF%478HiJQ"
  end

  factory :client do
    sequence :name do |n|
      "Client#{n}"
    end
    billing_rate BigDecimal.new("10.00")
  end

  factory :project do
    sequence :name do |n|
      "Project#{n}"
    end
  end

  factory :task do 
    sequence :name do |n|
      "Task#{n}"
    end
  end

  factory :event do 
    sequence :name do |n|
      "Event#{n}"
    end
    start_time Time.now
  end

  factory :report do 
    
  end 

  factory :collaboration do 

  end
end