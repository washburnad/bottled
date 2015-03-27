require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "Should find user by id string and email" do 
    user = FactoryGirl.create(:user)

    assert_equal user, User.user_from_id_or_email(user.id.to_s), "Should get user from id string"
    assert_equal user, User.user_from_id_or_email(user.email), "Should get user from email"
  end

  test "Should return user full name" do 
    user = FactoryGirl.create(:user, first_name: 'John', last_name: 'Doe')

    assert_equal 'John Doe', user.name
  end

  test "Should return space for nil names" do 
    user = FactoryGirl.create(:user, first_name: nil, last_name: nil)

    assert_equal ' ', user.name
  end
end
