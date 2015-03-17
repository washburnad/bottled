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
  end

  factory :project do
    sequence :name do |n|
      "Project#{n}"
    end
  end

end