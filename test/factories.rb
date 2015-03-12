FactoryGirl.define do
 
  factory :user do
    sequence :email do |n|
      "bottled#{n}@example.com"
    end
    password "gF%478HiJQ"
    password_confirmation "gF%478HiJQ"
  end

  factory :client do
    name "Client name"
  end

end